import 'package:flutter_test/flutter_test.dart';
import 'package:unier/core/utils/display_name.dart';

void main() {
  group('givenName', () {
    test('takes the first word', () {
      expect('Angle Operator'.givenName, 'Angle');
    });

    test('keeps a single-word name whole', () {
      expect('Andu'.givenName, 'Andu');
    });

    test('is empty for an empty name', () {
      expect('   '.givenName, '');
    });
  });

  group('initials', () {
    test('takes the first and last word', () {
      expect('Angle Operator'.initials, 'AO');
    });

    test('skips the middle names', () {
      expect('Sam Ray Jadoo'.initials, 'SJ');
    });

    test('falls back to one letter', () {
      expect('Chand'.initials, 'C');
    });

    test('is empty for an empty name', () {
      expect(''.initials, '');
    });
  });
}
