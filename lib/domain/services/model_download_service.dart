import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import 'ai_service.dart';

enum DownloadStatus { notDownloaded, downloading, downloaded, error }

class DownloadState {
  const DownloadState({
    required this.status,
    required this.progress,
    this.errorMessage,
  });

  final DownloadStatus status;
  final double progress; // 0.0 to 1.0
  final String? errorMessage;
}

class ModelDownloadNotifier extends StateNotifier<DownloadState> {
  ModelDownloadNotifier(this._ref) : super(const DownloadState(status: DownloadStatus.notDownloaded, progress: 0.0)) {
    checkStatus();
  }

  final Ref _ref;

  Future<String> _getModelPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/model.gguf';
  }

  Future<void> checkStatus() async {
    final path = await _getModelPath();
    if (File(path).existsSync()) {
      state = const DownloadState(status: DownloadStatus.downloaded, progress: 1.0);
    } else {
      state = const DownloadState(status: DownloadStatus.notDownloaded, progress: 0.0);
    }
  }

  Future<void> startDownload() async {
    final path = await _getModelPath();
    final file = File(path);
    if (file.existsSync()) {
      state = const DownloadState(status: DownloadStatus.downloaded, progress: 1.0);
      return;
    }

    state = const DownloadState(status: DownloadStatus.downloading, progress: 0.0);

    try {
      final client = HttpClient();
      // Using a fast mirror URL to download TinyLlama 1.1B Q4_K_M GGUF model
      final request = await client.getUrl(Uri.parse(
        'https://huggingface.co/TheBloke/TinyLlama-1.1B-Chat-v1.0-GGUF/resolve/main/tinyllama-1.1b-chat-v1.0.Q4_K_M.gguf'
      ));
      final response = await request.close();

      if (response.statusCode != 200) {
        throw Exception('Server returned status code ${response.statusCode}');
      }

      final contentLength = response.contentLength;
      var downloadedBytes = 0;
      final fileSink = file.openWrite();

      await response.listen(
        (chunk) {
          fileSink.add(chunk);
          downloadedBytes += chunk.length;
          if (contentLength > 0) {
            final progress = downloadedBytes / contentLength;
            state = DownloadState(status: DownloadStatus.downloading, progress: progress);
          }
        },
        onDone: () async {
          await fileSink.close();
          // Initialize model in AiService
          await _ref.read(aiServiceProvider).initLocalModel(path);
          state = const DownloadState(status: DownloadStatus.downloaded, progress: 1.0);
        },
        onError: (err) async {
          await fileSink.close();
          if (file.existsSync()) file.deleteSync();
          throw err;
        },
        cancelOnError: true,
      ).asFuture();
      
    } catch (e) {
      if (file.existsSync()) file.deleteSync();
      state = DownloadState(
        status: DownloadStatus.error,
        progress: 0.0,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> deleteModel() async {
    final path = await _getModelPath();
    final file = File(path);
    if (file.existsSync()) {
      file.deleteSync();
    }
    state = const DownloadState(status: DownloadStatus.notDownloaded, progress: 0.0);
  }
}

final modelDownloadProvider = StateNotifierProvider<ModelDownloadNotifier, DownloadState>((ref) {
  return ModelDownloadNotifier(ref);
});
