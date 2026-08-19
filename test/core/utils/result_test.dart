import 'package:flutter_test/flutter_test.dart';
import 'package:unier/core/error/failure.dart';
import 'package:unier/core/utils/result.dart';

void main() {
  const failure = CacheFailure('nope');

  test('ok carries its value', () {
    const result = Result<int>.ok(7);
    expect(result.isOk, isTrue);
    expect(result.valueOrNull, 7);
    expect(result.failureOrNull, isNull);
  });

  test('err carries its failure', () {
    const result = Result<int>.err(failure);
    expect(result.isErr, isTrue);
    expect(result.valueOrNull, isNull);
    expect(result.failureOrNull, failure);
  });

  test('map transforms an ok', () {
    expect(const Result<int>.ok(2).map((v) => v * 3).valueOrNull, 6);
  });

  test('map passes an err through untouched', () {
    expect(
      const Result<int>.err(failure).map((v) => v * 3).failureOrNull,
      failure,
    );
  });
}
