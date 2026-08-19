import 'package:intl/intl.dart';

import '../../domain/entities/greeting.dart';
import '../../domain/entities/part_of_day.dart';

extension GreetingFormatter on Greeting {
  // "Thursday, 13 August"
  String get dateLabel => DateFormat('EEEE, d MMMM').format(date);

  String get salutation => switch (partOfDay) {
    PartOfDay.morning => 'Good morning',
    PartOfDay.afternoon => 'Good afternoon',
    PartOfDay.evening => 'Good evening',
  };

  // Drops the comma while the name is still loading or the account has none.
  String get headline {
    final person = name?.trim();
    return person == null || person.isEmpty
        ? salutation
        : '$salutation, $person';
  }
}
