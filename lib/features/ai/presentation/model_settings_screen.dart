import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/gradient_scaffold.dart';
import '../../../core/widgets/sooubh_card.dart';
import '../../../core/widgets/primary_button.dart';
import '../engine/ai_engine.dart';

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

  void _simulateDownload(String id, String name) {
    setState(() {
      _downloadProgress[id] = 0.01;
    });

    // Animate progress up
    const steps = 20;
    int currentStep = 0;
    
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 150));
      if (!mounted) return false;

      currentStep++;
      setState(() {
        _downloadProgress[id] = currentStep / steps;
      });

      if (currentStep >= steps) {
        // Complete download
        ref.read(localAiProvider.notifier).downloadModel(id);
        setState(() {
          _downloadProgress.remove(id);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Downloaded and validated "$name" successfully.'),
            backgroundColor: AppTheme.success,
            behavior: SnackBarBehavior.floating,
          ),
        );
        return false;
      }
      return true;
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
                if (text.isEmpty) return;
                
                Navigator.of(context).pop();
                ref.read(localAiProvider.notifier).importCustomModel(text, '1.2 GB');

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Successfully loaded custom GGUF model: "$text".'),
                    backgroundColor: AppTheme.success,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
          ],
        );
      },
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
                        'On-Device Offline AI',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Sooubh AI supports on-device LLM inference using llama.cpp. By downloading a small model, you can ask questions and explore features fully offline without any data leaving your phone.',
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
                TextButton.icon(
                  onPressed: _showImportDialog,
                  icon: const Icon(Icons.file_upload_outlined, size: 18),
                  label: const Text('Import GGUF'),
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
                                onPressed: () => _simulateDownload(model.id, model.name),
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
