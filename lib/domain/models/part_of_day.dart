/// The stretch of the day a greeting belongs to.
enum PartOfDay {
  /// From [morningStartHour] until [afternoonStartHour].
  morning,

  /// From [afternoonStartHour] until [eveningStartHour].
  afternoon,

  /// From [eveningStartHour] until [morningStartHour].
  evening;

  /// Hour at which [morning] begins, on a 24-hour clock.
  static const int morningStartHour = 5;

  /// Hour at which [afternoon] begins.
  static const int afternoonStartHour = 12;

  /// Hour at which [evening] begins.
  static const int eveningStartHour = 17;

  /// The part of the day that contains [time].
  factory PartOfDay.at(DateTime time) {
    final hour = time.hour;
    if (hour >= eveningStartHour || hour < morningStartHour) {
      return PartOfDay.evening;
    }
    if (hour >= afternoonStartHour) return PartOfDay.afternoon;
    return PartOfDay.morning;
  }
}
