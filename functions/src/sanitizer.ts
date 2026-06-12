/**
 * Server-side mirror of the Flutter PrivacySanitizer — defense in depth.
 * Even though the client only sends safe signals, the backend never
 * trusts input before it reaches the AI model (PRD section 4).
 */
const FORBIDDEN: RegExp[] = [
  /\d{9,18}/, // account-number-like sequences
  /(?:\u20b9|rs\.?|inr)\s*\d/i, // currency amounts
  /\b\d{4}[-\s]?\d{4}[-\s]?\d{4}(?:[-\s]?\d{4})?\b/, // card numbers
  /\b(cvv|pin|otp|password)\b/i, // secrets
];

export function isSafe(text: string): boolean {
  return FORBIDDEN.every((pattern) => !pattern.test(text));
}

/** Only these chat prompt types are permitted (PRD Feature 7). */
export const ALLOWED_PROMPT_TYPES = new Set([
  "insight",
  "score",
  "goal",
  "recommendation",
]);

/** Throws when any string value fails the safety check — fails closed. */
export function assertSafePayload(payload: Record<string, unknown>): void {
  for (const value of Object.values(payload)) {
    if (typeof value === "string" && !isSafe(value)) {
      throw new Error("PrivacySanitizer blocked unsafe value before AI dispatch.");
    }
  }
}
