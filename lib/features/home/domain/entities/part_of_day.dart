// The stretch of the day a greeting belongs to.
enum PartOfDay {
  morning,
  afternoon,
  evening;

  static const int morningStartHour = 5;
  static const int afternoonStartHour = 12;
  static const int eveningStartHour = 17;

  // The part of the day that contains time.
  factory PartOfDay.at(DateTime time) {
    final hour = time.hour;
    if (hour >= eveningStartHour || hour < morningStartHour) {
      return PartOfDay.evening;
    }
    if (hour >= afternoonStartHour) return PartOfDay.afternoon;
    return PartOfDay.morning;
  }
}
