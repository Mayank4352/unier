import 'part_of_day.dart';

/// The date line and salutation shown at the top of the home screen.
class Greeting {
  const Greeting({
    required this.date,
    required this.partOfDay,
    this.name,
  });

  /// The moment the greeting describes.
  final DateTime date;

  /// Which salutation to use.
  final PartOfDay partOfDay;

  /// The person being greeted, or `null` while the session is still loading.
  final String? name;

  /// A copy of this greeting addressed to [name].
  Greeting withName(String? name) =>
      Greeting(date: date, partOfDay: partOfDay, name: name);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Greeting &&
          other.date == date &&
          other.partOfDay == partOfDay &&
          other.name == name;

  @override
  int get hashCode => Object.hash(date, partOfDay, name);
}
