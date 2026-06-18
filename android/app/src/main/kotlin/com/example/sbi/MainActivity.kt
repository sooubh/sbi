package com.example.sbi

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "sooubh_ai/llama_cpp")
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "generate" -> result.error(
                        "LLAMA_CPP_NOT_LINKED",
                        "Native llama.cpp runtime is not bundled yet. Add JNI bindings and GGUF loading to enable real inference.",
                        null
                    )
                    else -> result.notImplemented()
                }
            }
    }
}
