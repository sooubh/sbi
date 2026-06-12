import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../models/weekly_story.dart';
import '../../services/weekly_story_service.dart';

/// Immersive Weekly Financial Story: segmented progress, tap-to-advance
/// gradient slides — a 30-second privacy-safe recap of the week.
class WeeklyStoryScreen extends ConsumerStatefulWidget {
  const WeeklyStoryScreen({super.key});

  @override
  ConsumerState<WeeklyStoryScreen> createState() => _WeeklyStoryScreenState();
}

class _WeeklyStoryScreenState extends ConsumerState<WeeklyStoryScreen> {
  final _pageController = PageController();
  int _index = 0;

  static const _gradients = [
    [Color(0xFF14377D), Color(0xFF2557C9)],
    [Color(0xFF0E2A5C), Color(0xFF14377D)],
    [Color(0xFF2557C9), Color(0xFF14377D)],
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _advance(int total, {required bool forward}) {
    if (forward) {
      if (_index >= total - 1) {
        Navigator.of(context).pop();
        return;
      }
      _pageController.nextPage(
          duration: const Duration(milliseconds: 280), curve: Curves.easeOut);
    } else if (_index > 0) {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 280), curve: Curves.easeOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final story = ref.watch(weeklyStoryProvider);

    return Scaffold(
      backgroundColor: AppColors.deepBlue,
      body: story.when(
        loading: () => const Center(
            child: CircularProgressIndicator(color: Colors.white70)),
        error: (_, __) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Could not load your story',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
              const SizedBox(height: Insets.m),
              FilledButton(
                style: FilledButton.styleFrom(
                    backgroundColor: Colors.white, foregroundColor: AppColors.deepBlue, minimumSize: const Size(160, 44)),
                onPressed: () => ref.invalidate(weeklyStoryProvider),
                child: const Text('Try again'),
              ),
            ],
          ),
        ),
        data: (data) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapUp: (details) {
            final width = MediaQuery.of(context).size.width;
            _advance(data.slides.length, forward: details.globalPosition.dx > width / 3);
          },
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _index = i),
                itemCount: data.slides.length,
                itemBuilder: (_, i) => _Slide(
                  slide: data.slides[i],
                  colors: _gradients[i % _gradients.length],
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Insets.m),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: Insets.s),
                      Row(
                        children: [
                          for (var i = 0; i < data.slides.length; i++)
                            Expanded(
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                height: 3,
                                margin: const EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                  color: i <= _index ? Colors.white : Colors.white24,
                                  borderRadius: BorderRadius.circular(Corners.chip),
                                ),
                              ),
                            ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(data.weekLabel,
                              style: const TextStyle(fontSize: 12, color: Colors.white70)),
                          const Spacer(),
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.close_rounded, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  const _Slide({required this.slide, required this.colors});

  final StorySlide slide;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(Insets.xl),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(flex: 2),
            Text(
              slide.kicker,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.6,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: Insets.m),
            if (slide.statValue != null) ...[
              Text(slide.statValue!,
                  style: const TextStyle(fontSize: 56, fontWeight: FontWeight.w800, color: Colors.white, height: 1)),
              const SizedBox(height: Insets.s),
            ],
            Text(slide.headline,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.white, height: 1.2)),
            const SizedBox(height: Insets.m),
            Text(slide.detail,
                style: TextStyle(fontSize: 15, height: 1.5, color: Colors.white.withValues(alpha: 0.9))),
            const Spacer(flex: 3),
            if (slide.signal != null) ...[
              Row(
                children: [
                  const Icon(Icons.shield_rounded, size: 13, color: Colors.white70),
                  const SizedBox(width: 6),
                  Text('From safe signal: ${slide.signal}',
                      style: const TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.white70)),
                ],
              ),
              const SizedBox(height: Insets.s),
            ],
            Text('Privacy-safe signals only — never transactions.',
                style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.55))),
          ],
        ),
      ),
    );
  }
}
