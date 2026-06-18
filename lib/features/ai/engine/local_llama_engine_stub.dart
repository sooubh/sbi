import 'dart:typed_data';

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

class LocalLlamaEngine {
  static Future<bool> isGgufFile(String path) async => false;

  static Future<GgufValidationResult> validatePickedFile({
    required String name,
    String? path,
    Uint8List? bytes,
    int? size,
  }) async {
    final isValid = name.toLowerCase().endsWith('.gguf') && _hasGgufMagic(bytes);
    return GgufValidationResult(isValid: isValid, name: name, path: path, bytes: size);
  }

  static Future<LlamaEngineResult> generate({
    required String prompt,
    required String modelName,
    required String? modelPath,
    required String Function(String prompt, String modelName) fallbackGenerator,
  }) async {
    return LlamaEngineResult(
      text: '${fallbackGenerator(prompt, modelName)}\n\nRuntime note: Native llama.cpp is unavailable on this platform/build.',
      source: 'Offline Demo KB',
      usedNativeRuntime: false,
    );
  }

  static bool _hasGgufMagic(Uint8List? bytes) {
    if (bytes == null || bytes.length < 4) return false;
    return bytes[0] == 0x47 && bytes[1] == 0x47 && bytes[2] == 0x55 && bytes[3] == 0x46;
  }
}
