import 'dart:io';

import 'package:flutter/services.dart';

class LlamaEngineResult {
  final String text;
  final String source;
  final bool usedNativeRuntime;

  const LlamaEngineResult({
    required this.text,
    required this.source,
    required this.usedNativeRuntime,
  });
}

class GgufValidationResult {
  final bool isValid;
  final String? name;
  final String? path;
  final int? bytes;

  const GgufValidationResult({
    required this.isValid,
    this.name,
    this.path,
    this.bytes,
  });
}

class LocalLlamaEngine {
  static const MethodChannel _channel = MethodChannel('sooubh_ai/llama_cpp');

  static Future<bool> isGgufFile(String path) async {
    if (!path.toLowerCase().endsWith('.gguf')) return false;
    final file = File(path);
    if (!await file.exists()) return false;
    final bytes = await file.openRead(0, 4).first;
    return _hasGgufMagic(Uint8List.fromList(bytes));
  }

  static Future<GgufValidationResult> validatePickedFile({
    required String name,
    String? path,
    Uint8List? bytes,
    int? size,
  }) async {
    var isValid = name.toLowerCase().endsWith('.gguf');
    if (isValid && bytes != null) {
      isValid = _hasGgufMagic(bytes);
    } else if (isValid && path != null) {
      isValid = await isGgufFile(path);
    } else {
      isValid = false;
    }
    return GgufValidationResult(isValid: isValid, name: name, path: path, bytes: size);
  }

  static Future<LlamaEngineResult> generate({
    required String prompt,
    required String modelName,
    required String? modelPath,
    required String Function(String prompt, String modelName) fallbackGenerator,
  }) async {
    final localPath = modelPath;
    final hasValidatedGguf = localPath != null && await isGgufFile(localPath);

    if (hasValidatedGguf) {
      try {
        final text = await _channel.invokeMethod<String>('generate', {
          'modelPath': localPath,
          'prompt': prompt,
          'maxTokens': 256,
          'temperature': 0.2,
        });
        if (text != null && text.trim().isNotEmpty) {
          return LlamaEngineResult(
            text: '[$modelName - llama.cpp native]:\n${text.trim()}',
            source: 'llama.cpp Native',
            usedNativeRuntime: true,
          );
        }
      } on MissingPluginException {
        // Native llama.cpp bridge is not linked in this Flutter shell yet.
      } on PlatformException {
        // Fall back below; the UI still has a validated GGUF path.
      }
    }

    final fallback = fallbackGenerator(prompt, modelName);
    final reason = hasValidatedGguf
        ? 'Validated GGUF is registered, but the native llama.cpp method channel is not linked in this build.'
        : 'No validated GGUF model is active. Import a real .gguf file to enable native inference once the bridge is bundled.';

    return LlamaEngineResult(
      text: '$fallback\n\nRuntime note: $reason',
      source: hasValidatedGguf ? 'llama.cpp Pending Native Bridge' : 'Offline Demo KB',
      usedNativeRuntime: false,
    );
  }

  static bool _hasGgufMagic(Uint8List bytes) {
    if (bytes.length < 4) return false;
    return bytes[0] == 0x47 && bytes[1] == 0x47 && bytes[2] == 0x55 && bytes[3] == 0x46;
  }
}
