import 'package:flutter/material.dart';
import '../../../data/models/weekly_story.dart';

class WeeklyStoryModal extends StatefulWidget {
  final WeeklyStory story;

  const WeeklyStoryModal({super.key, required this.story});

  static void show(BuildContext context, WeeklyStory story) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Story Barrier',
      barrierColor: Colors.black.withValues(alpha: 0.85),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return WeeklyStoryModal(story: story);
      },
    );
  }

  @override
  State<WeeklyStoryModal> createState() => _WeeklyStoryModalState();
}

class _WeeklyStoryModalState extends State<WeeklyStoryModal> {
  late PageController _pageController;
  int _currentIndex = 0;
  final int _slideCount = 5;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildSlide({
    required BuildContext context,
    required String title,
    required String emoji,
    required Widget content,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 64),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 32),
          DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 18,
              height: 1.5,
            ) ?? const TextStyle(),
            textAlign: TextAlign.center,
            child: content,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final story = widget.story;

    final slides = [
      _buildSlide(
        context: context,
        emoji: '📈',
        title: 'Weekly Summary',
        bgColor: const Color(0xFF5E35B1),
        content: Text(
          story.summaryText,
        ),
      ),
      _buildSlide(
        context: context,
        emoji: '💰',
        title: 'Savings Recap',
        bgColor: const Color(0xFF00897B),
        content: Column(
          children: [
            const Text('You set aside extra money this week:'),
            const SizedBox(height: 12),
            Text(
              '₹${story.savedThisWeek.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text('Great job building your emergency buffer!'),
          ],
        ),
      ),
      _buildSlide(
        context: context,
        emoji: '🍔',
        title: 'Spending Check',
        bgColor: const Color(0xFF283593),
        content: Column(
          children: [
            const Text('Your spending habits are improving:'),
            const SizedBox(height: 12),
            Text(
              '${story.spendChangePercent}% Less Spent',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text('Food and dining expenses decreased compared to last week.'),
          ],
        ),
      ),
      _buildSlide(
        context: context,
        emoji: '🎯',
        title: 'Goal Tracker',
        bgColor: const Color(0xFF7B1FA2),
        content: Column(
          children: [
            const Text('You are getting closer to your goal:'),
            const SizedBox(height: 12),
            Text(
              '+${story.goalProgressChange}% Progress',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text('You are now 72% closer to complete your Emergency Fund.'),
          ],
        ),
      ),
      _buildSlide(
        context: context,
        emoji: '🛡️',
        title: 'AI Smart Tip',
        bgColor: const Color(0xFF00BFA5),
        content: const Column(
          children: [
            Text('To accelerate your goal savings:'),
            SizedBox(height: 12),
            Text(
              'Activate Auto-Save',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text('Auto-save rounds up your transaction changes and saves them automatically.'),
          ],
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Top indicators bar
              Row(
                children: List.generate(
                  _slideCount,
                  (index) => Expanded(
                    child: Container(
                      height: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: index <= _currentIndex
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),
              
              // Top Close Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sooubh Weekly Story',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Story Slides PageView
              Expanded(
                child: GestureDetector(
                  onTapDown: (details) {
                    final screenWidth = MediaQuery.of(context).size.width;
                    if (details.globalPosition.dx < screenWidth * 0.3) {
                      // Tap Left: Go Back
                      if (_currentIndex > 0) {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                        );
                      }
                    } else {
                      // Tap Right: Go Forward
                      if (_currentIndex < _slideCount - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        // Close story on final tap
                        Navigator.of(context).pop();
                      }
                    }
                  },
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _slideCount,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return slides[index];
                    },
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Swipe/Tap Navigation tips
              Text(
                'Tap left to go back, tap right to advance',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.5),
                ),
              ),
              
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
