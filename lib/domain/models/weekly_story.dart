/// One slide in the Weekly Financial Story.
class StorySlide {
  const StorySlide({
    required this.kicker,
    required this.headline,
    required this.detail,
    this.statValue,
    this.signal,
  });

  /// Small caps label, e.g. 'FINANCIAL HEALTH'.
  final String kicker;

  /// Optional big emphasis value, e.g. '+5' or '72%'.
  final String? statValue;
  final String headline;
  final String detail;

  /// The safe signal this slide is derived from (explainability).
  final String? signal;
}

/// A privacy-safe weekly recap derived from behavioral signals only.
class WeeklyStory {
  const WeeklyStory({required this.weekLabel, required this.slides});

  final String weekLabel;
  final List<StorySlide> slides;
}
