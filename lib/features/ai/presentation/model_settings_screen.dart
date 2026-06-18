import 'dart:async';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/gradient_scaffold.dart';
import '../../../core/widgets/sooubh_card.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../data/repositories/state_providers.dart';
import '../engine/ai_engine.dart';
import '../engine/local_llama_engine.dart';

class ModelSettingsScreen extends ConsumerStatefulWidget {
  const ModelSettingsScreen({super.key});

  @override
  ConsumerState<ModelSettingsScreen> createState() => _ModelSettingsScreenState();
}

class _ModelSettingsScreenState extends ConsumerState<ModelSettingsScreen> {
  final Map<String, double> _downloadProgress = {};
  final TextEditingController _modelNameController = TextEditingController();

  @override
  void dispose() {
    _modelNameController.dispose();
    super.dispose();
  }

  void _startDemoDownload(String id, String name) {
    setState(() {
      _downloadProgress[id] = 0.001;
    });

    const tick = Duration(milliseconds: 120);
    Timer.periodic(tick, (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      final next = (_downloadProgress[id] ?? 0) + 0.08;
      if (next >= 1) {
        timer.cancel();
        ref.read(localAiProvider.notifier).downloadModel(id);
        setState(() {
          _downloadProgress.remove(id);
        });

        ref.read(engagementProvider.notifier).trackEvent(
          'Enabled Demo Offline Model',
          coins: 20,
          details: 'Enabled $id in simulated offline knowledge-base mode. No GGUF binary was downloaded.',
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Enabled "$name" demo model. Real GGUF download/inference is not bundled yet.'),
            backgroundColor: AppTheme.warning,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        setState(() {
          _downloadProgress[id] = next;
        });
      }
    });
  }

  void _showImportDialog() {
    _modelNameController.clear();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.cardBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.cardRadius),
          ),
          title: Text(
            'Import GGUF Model',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select or type a local GGUF model file path to load onto the device.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _modelNameController,
                decoration: InputDecoration(
                  hintText: 'e.g. MyLocalModel-Q4_K_M.gguf',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel', style: TextStyle(color: AppTheme.textSecondary)),
            ),
            PrimaryButton(
              label: 'Import Model',
              onPressed: () {
                final text = _modelNameController.text.trim();
                if (text.isEmpty || !text.toLowerCase().endsWith('.gguf')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Enter a .gguf file name/path to register a local model.'),
                      backgroundColor: AppTheme.error,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  return;
                }
                
                Navigator.of(context).pop();
                final normalized = text.replaceAll('\\', '/');
                _importValidatedGguf(normalized.split('/').last, path: text);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickAndImportGguf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['gguf'],
      allowMultiple: false,
      withData: true,
    );
    final file = result?.files.single;
    if (file == null) return;
    await _importValidatedGguf(
      file.name,
      path: file.path,
      bytes: file.bytes,
      size: file.size,
    );
  }

  Future<void> _importValidatedGguf(
    String name, {
    String? path,
    List<int>? bytes,
    int? size,
  }) async {
    final validation = await LocalLlamaEngine.validatePickedFile(
      name: name,
      path: path,
      bytes: bytes == null ? null : Uint8List.fromList(bytes),
      size: size,
    );
    if (!mounted) return;
    if (!validation.isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid GGUF file. Pick a real .gguf file with a valid GGUF header.'),
          backgroundColor: AppTheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final fileName = validation.name ?? name;
    final sizeMb = ((validation.bytes ?? 0) / (1024 * 1024)).toStringAsFixed(1);
    ref.read(localAiProvider.notifier).importCustomModel(
      fileName,
      '$sizeMb MB',
      localPath: validation.path,
    );
    ref.read(engagementProvider.notifier).trackEvent(
      'Imported GGUF Model',
      coins: 40,
      details: 'Validated and registered local GGUF model ${validation.path ?? fileName}',
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Validated and registered $fileName. llama.cpp native bridge will use it when bundled.'),
        backgroundColor: AppTheme.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final models = ref.watch(localAiProvider);

    return GradientScaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header back trigger
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_rounded),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Text(
                  'Local AI Configuration',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Intro Card
            SooubhCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.offline_bolt_rounded, color: AppTheme.aiTeal, size: 28),
                      const SizedBox(width: 12),
                      Text(
                        'Offline AI Demo Mode',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'This build includes a safe simulated offline knowledge base. It does not download real GGUF binaries or run llama.cpp yet; add a native llama.cpp bridge before presenting this as true on-device inference.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Models section header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Available Models',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Row(
                  children: [
                    TextButton.icon(
                      onPressed: _pickAndImportGguf,
                      icon: const Icon(Icons.folder_open_rounded, size: 18),
                      label: const Text('Pick GGUF'),
                    ),
                    TextButton.icon(
                      onPressed: _showImportDialog,
                      icon: const Icon(Icons.edit_document, size: 18),
                      label: const Text('Path'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Models List
            Column(
              children: models.map((model) {
                final isDownloading = _downloadProgress.containsKey(model.id);
                final progress = _downloadProgress[model.id] ?? 0.0;
                
                return Container(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  child: SooubhCard(
                    hasAiBorder: model.isActive,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        model.name,
                                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      if (model.isActive) ...[
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: AppTheme.aiTeal.withValues(alpha: 0.1),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: const Text(
                                            'Active',
                                            style: TextStyle(
                                              color: AppTheme.aiTeal,
                                              fontSize: 8,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Size: ${model.size}',
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            if (!model.isDownloaded && !isDownloading)
                              IconButton(
                                icon: const Icon(Icons.download_rounded, color: AppTheme.sbiBlue),
                                onPressed: () => _startDemoDownload(model.id, model.name),
                              )
                            else if (isDownloading)
                              Text(
                                '${(progress * 100).toStringAsFixed(0)}%',
                                style: const TextStyle(
                                  color: AppTheme.sbiBlue,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            else if (!model.isActive)
                              TextButton(
                                onPressed: () => ref.read(localAiProvider.notifier).activateModel(model.id),
                                child: const Text('Use Model'),
                              )
                            else
                              const Icon(Icons.check_circle_outline_rounded, color: AppTheme.aiTeal),
                          ],
                        ),
                        if (isDownloading) ...[
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: progress,
                              minHeight: 6,
                              backgroundColor: AppTheme.background,
                              valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.sbiBlue),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
