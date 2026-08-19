/// The caption and voice preferences surfaced on the home screen's status card.
class CallSettings {
  const CallSettings({
    required this.captionsEnabled,
    required this.voiceName,
    this.readyForCalls = true,
  });

  /// The state a fresh install starts in.
  static const CallSettings defaults = CallSettings(
    captionsEnabled: true,
    voiceName: 'Sam',
  );

  /// Whether live captions run automatically on an incoming call.
  final bool captionsEnabled;

  /// The synthesised voice used to read replies aloud.
  final String voiceName;

  /// Whether the device is set up to receive calls.
  final bool readyForCalls;

  /// A copy with the given fields replaced.
  CallSettings copyWith({
    bool? captionsEnabled,
    String? voiceName,
    bool? readyForCalls,
  }) {
    return CallSettings(
      captionsEnabled: captionsEnabled ?? this.captionsEnabled,
      voiceName: voiceName ?? this.voiceName,
      readyForCalls: readyForCalls ?? this.readyForCalls,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CallSettings &&
          other.captionsEnabled == captionsEnabled &&
          other.voiceName == voiceName &&
          other.readyForCalls == readyForCalls;

  @override
  int get hashCode => Object.hash(captionsEnabled, voiceName, readyForCalls);
}
