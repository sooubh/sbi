import { initializeApp } from "firebase-admin/app";
import { FieldValue, getFirestore } from "firebase-admin/firestore";
import { onDocumentCreated } from "firebase-functions/v2/firestore";
import { HttpsError, onCall } from "firebase-functions/v2/https";

import { generateExplanation, generateInsight } from "./gemini";
import { ALLOWED_PROMPT_TYPES, assertSafePayload, isSafe } from "./sanitizer";

initializeApp();
const db = getFirestore();

function humanize(signal: string): string {
  const text = signal.replace(/_/g, " ");
  return text.charAt(0).toUpperCase() + text.slice(1);
}

/**
 * PRD section 15 flow: a safe signal lands in `financialSignals`,
 * is mapped to a privacy-safe prompt, Gemini generates the insight,
 * and the structured result is stored for the app to display.
 */
export const generateInsightOnSignal = onDocumentCreated(
  "financialSignals/{signalId}",
  async (event) => {
    const data = event.data?.data();
    if (!data || !data.userId) return;

    // Only the safe-signal shape is accepted — anything else fails closed.
    const payload = {
      signal: String(data.signalType ?? ""),
      category: String(data.category ?? ""),
      privacyLevel: String(data.privacyLevel ?? "standard"),
    };
    assertSafePayload(payload);

    const output = await generateInsight(
      payload.signal,
      payload.category,
      payload.privacyLevel
    );

    await db.collection("insights").add({
      userId: data.userId,
      title: humanize(payload.signal),
      body: output.insight,
      recommendation: output.recommendation,
      reason: output.reason,
      confidence: output.confidence,
      signalType: payload.signal,
      createdAt: FieldValue.serverTimestamp(),
    });

    await db.collection("timeline").add({
      userId: data.userId,
      eventType: "ai_insight",
      message: "Insight generated from a safe signal",
      explainNote: output.reason,
      createdAt: FieldValue.serverTimestamp(),
    });
  }
);

/** Explain-only chat (PRD Feature 7): allowed prompt types only. */
export const explainChat = onCall(async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "Sign-in required.");
  }
  const promptType = String(request.data?.promptType ?? "");
  const privacyLevel = String(request.data?.privacyLevel ?? "standard");

  if (!ALLOWED_PROMPT_TYPES.has(promptType)) {
    throw new HttpsError(
      "invalid-argument",
      "Only explanation prompts are allowed on this surface."
    );
  }
  if (!isSafe(promptType) || !isSafe(privacyLevel)) {
    throw new HttpsError("invalid-argument", "Unsafe input rejected.");
  }

  const explanation = await generateExplanation(promptType, privacyLevel);

  await db.collection("aiSessions").add({
    userId: request.auth.uid,
    promptType,
    responseType: "explanation",
    privacyLevel,
    createdAt: FieldValue.serverTimestamp(),
  });

  return { explanation };
});
