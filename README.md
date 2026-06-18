# Sooubh AI

Sooubh AI is a Flutter demo for an SBI/YONO-style banking assistant. It includes a mobile shell, service discovery, onboarding flows, mock transactions, gamification, a web analytics dashboard, and a multi-layer AI assistant.

## Current AI behavior

The app intentionally separates real and demo AI paths:

- **Rule engine**: deterministic banking intents such as KYC, UPI, send money, goals, and service discovery.
- **Offline demo knowledge base**: local template responses that simulate a small offline model experience.
- **Gemini integration**: optional REST and Live WebSocket paths when a user adds a Gemini API key in the developer configuration UI.

## Important limitation: llama.cpp / GGUF

This build does **not** bundle native llama.cpp inference and does **not** download real GGUF model binaries. The local model screen now labels this clearly as demo mode. To make it production-real, add:

1. A native llama.cpp Flutter bridge.
2. Real model catalog URLs.
3. GGUF header validation.
4. SHA256 checksum verification.
5. Local model path persistence.
6. Runtime inference and fallback handling.

## Navigation notes

The app has central named-route handling for the main tabs, Send Money, Financial Coach, model settings, dashboard, and AI-generated deep links such as `/onboarding/kyc`, `/onboarding/upi`, `/services/fd`, `/services/sip`, and `/goals/create`.

## Running locally

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

## Known demo-only areas

- Banking data is mock/demo data.
- KYC/OCR/video flows are simulated.
- Card lock and Auto-Save are local demo state.
- Gemini keys are entered client-side for hackathon/demo use only; production should proxy and secure API access.

## Native llama.cpp integration plan

The Dart layer now validates imported GGUF files and calls a `MethodChannel` named `sooubh_ai/llama_cpp` for native generation when a platform runtime is bundled. If the native method is missing, the app falls back to the offline knowledge base and displays a runtime note instead of pretending llama.cpp ran.

Expected native method:

```text
channel: sooubh_ai/llama_cpp
method: generate
args: { modelPath, prompt, maxTokens, temperature }
returns: generated text
```

## Permission coverage

Platform manifests include permissions/usage descriptions for internet/network access, camera, microphone, notifications, and user-selected media/files. Runtime permission requests are available from the AI & Dev Console.
