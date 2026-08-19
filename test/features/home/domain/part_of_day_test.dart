import 'package:flutter_test/flutter_test.dart';
import 'package:unier/features/home/domain/entities/part_of_day.dart';

void main() {
  PartOfDay at(int hour) => PartOfDay.at(DateTime(2026, 8, 13, hour));

  test('early hours read as evening', () {
    expect(at(0), PartOfDay.evening);
    expect(at(4), PartOfDay.evening);
  });

  test('morning starts at 5', () {
    expect(at(5), PartOfDay.morning);
    expect(at(11), PartOfDay.morning);
  });

  test('afternoon starts at noon', () {
    expect(at(12), PartOfDay.afternoon);
    expect(at(16), PartOfDay.afternoon);
  });

  test('evening starts at 17', () {
    expect(at(17), PartOfDay.evening);
    expect(at(23), PartOfDay.evening);
  });
}
