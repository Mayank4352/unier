import '../error/failure.dart';

// Wraps the outcome of an operation that can fail.
sealed class Result<T> {
  const Result();

  const factory Result.ok(T value) = Ok<T>._;

  const factory Result.err(Failure failure) = Err<T>._;

  bool get isOk => this is Ok<T>;
  bool get isErr => this is Err<T>;

  T? get valueOrNull => switch (this) {
    Ok<T>(:final value) => value,
    Err<T>() => null,
  };

  Failure? get failureOrNull => switch (this) {
    Ok<T>() => null,
    Err<T>(:final failure) => failure,
  };

  // Applies transform to the value of an Ok, passing an Err through.
  Result<R> map<R>(R Function(T value) transform) => switch (this) {
    Ok<T>(:final value) => Result<R>.ok(transform(value)),
    Err<T>(:final failure) => Result<R>.err(failure),
  };
}

// A successful Result.
final class Ok<T> extends Result<T> {
  const Ok._(this.value);
  final T value;

  @override
  String toString() => 'Ok<$T>($value)';
}

// A failed Result.
final class Err<T> extends Result<T> {
  const Err._(this.failure);
  final Failure failure;

  @override
  String toString() => 'Err<$T>($failure)';
}
