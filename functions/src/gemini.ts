import { GoogleGenerativeAI } from "@google/generative-ai";

/** PRD section 16 prompt — the AI only ever sees safe signals. */
const SYSTEM_PROMPT =
  "You are Compass, a privacy-first banking engagement agent. Generate a " +
  "short, helpful, plain-language insight from the following safe behavioral " +
  "signal. Do not expose any raw transaction details, exact balances, account " +
  "numbers, or sensitive private values. Keep the response concise, friendly, " +
  "and banking-professional.";

export interface InsightOutput {
  insight: string;
  recommendation: string;
  reason: string;
  confidence: number;
}

function model() {
  const key = process.env.GEMINI_API_KEY;
  if (!key) return null;
  return new GoogleGenerativeAI(key).getGenerativeModel({ model: "gemini-1.5-flash" });
}

function parseJson(text: string): Record<string, unknown> {
  return JSON.parse(text.replace(/```json|```/g, "").trim());
}

/** Deterministic fallback so the demo works without a Gemini API key. */
export function templateInsight(signal: string): InsightOutput {
  const templates: Record<string, InsightOutput> = {
    savings_consistency_improved: {
      insight: "Your savings consistency has improved recently. Nice momentum!",
      recommendation: "Consider a small increase to your monthly auto-save.",
      reason: "Derived from the savings_consistency_improved signal only.",
      confidence: 0.86,
    },
    spending_up_in_food_category: {
      insight: "Food-related spending is higher than usual this month.",
      recommendation: "Set a weekly spending limit for the food category.",
      reason: "Only the category trend was analyzed — no amounts or merchants.",
      confidence: 0.84,
    },
    travel_event_detected: {
      insight: "A travel-related event was detected.",
      recommendation: "Consider setting a short-term trip budget.",
      reason: "A behavioral pattern only — no booking details were read.",
      confidence: 0.78,
    },
    bill_due_soon: {
      insight: "An upcoming bill pattern was detected for this week.",
      recommendation: "Enable a bill reminder so it is never missed.",
      reason: "The biller name and amount were never shared with the AI.",
      confidence: 0.91,
    },
    income_pattern_detected: {
      insight: "A recurring income pattern was identified.",
      recommendation: "Automate a savings transfer right after income arrives.",
      reason: "Recognized from timing patterns alone — the value stays private.",
      confidence: 0.88,
    },
    goal_progress_slow: {
      insight: "One of your goals is progressing slower than its usual pace.",
      recommendation: "A small weekly top-up would bring it back on schedule.",
      reason: "Only progress percentages were analyzed — never amounts.",
      confidence: 0.8,
    },
  };
  return (
    templates[signal] ?? {
      insight: "A positive trend was detected in your financial behavior.",
      recommendation: "Keep your current routine going.",
      reason: "Derived from a generic wellness trend signal.",
      confidence: 0.75,
    }
  );
}

/** Signal -> safe prompt -> Gemini -> structured output (PRD section 15). */
export async function generateInsight(
  signal: string,
  category: string,
  privacyLevel: string
): Promise<InsightOutput> {
  const gemini = model();
  if (gemini) {
    try {
      const result = await gemini.generateContent(
        `${SYSTEM_PROMPT}\nRespond ONLY with JSON in this exact shape: ` +
          `{"insight": string, "recommendation": string, "reason": string, "confidence": number}.\n` +
          `Safe signal payload: ${JSON.stringify({ signal, category, privacyLevel })}`
      );
      const parsed = parseJson(result.response.text());
      if (typeof parsed.insight === "string") {
        return {
          insight: String(parsed.insight),
          recommendation: String(parsed.recommendation ?? ""),
          reason: String(parsed.reason ?? ""),
          confidence: Number(parsed.confidence ?? 0.8),
        };
      }
    } catch (error) {
      console.warn("Gemini failed, falling back to template.", error);
    }
  }
  return templateInsight(signal);
}

const EXPLANATIONS: Record<string, string> = {
  insight:
    "Insights are generated from privacy-safe behavioral signals such as " +
    "category trends and pattern changes. No balances, amounts or account " +
    "numbers are ever read.",
  score:
    "Your Financial Health Score summarizes savings, spending, goals, " +
    "consistency and stability — each derived from behavioral patterns, " +
    "never from raw financial values.",
  goal:
    "Goal coaching tracks only progress percentages against expected pace. " +
    "Small recurring auto-saves are the most reliable way to improve a goal.",
  recommendation:
    "Recommendations appear when safe signals suggest a helpful action, and " +
    "each one always includes the reason it was shown.",
};

/** Explain-only chat answer for an allowed prompt type. */
export async function generateExplanation(
  promptType: string,
  privacyLevel: string
): Promise<string> {
  const gemini = model();
  if (gemini) {
    try {
      const result = await gemini.generateContent(
        `${SYSTEM_PROMPT}\nThe user asked an allowed explanation question of type ` +
          `"${promptType}" at privacy level "${privacyLevel}". Explain in 2-3 friendly ` +
          `sentences how this works, without revealing any raw financial data. Respond with plain text only.`
      );
      const text = result.response.text().trim();
      if (text) return text;
    } catch (error) {
      console.warn("Gemini failed, falling back to template.", error);
    }
  }
  return EXPLANATIONS[promptType] ?? EXPLANATIONS.insight;
}
