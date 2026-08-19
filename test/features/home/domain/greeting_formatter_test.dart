import 'package:flutter_test/flutter_test.dart';
import 'package:unier/features/home/domain/entities/greeting.dart';
import 'package:unier/features/home/domain/entities/part_of_day.dart';
import 'package:unier/features/home/presentation/formatters/greeting_formatter.dart';

void main() {
  final thursday = DateTime(2026, 8, 13, 14);

  Greeting greeting({String? name}) =>
      Greeting(date: thursday, partOfDay: PartOfDay.at(thursday), name: name);

  test('formats the date line', () {
    expect(greeting().dateLabel, 'Thursday, 13 August');
  });

  test('addresses the person by name', () {
    expect(greeting(name: 'Andu').headline, 'Good afternoon, Andu');
  });

  test('drops the comma when there is no name', () {
    expect(greeting().headline, 'Good afternoon');
    expect(greeting(name: '  ').headline, 'Good afternoon');
  });
}
