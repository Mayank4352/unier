/// Wraps the outcome of an operation that can fail.
///
/// Repositories and services return a [Result] instead of throwing, so callers
/// are forced to handle the failure path:
///
/// ```dart
/// switch (await repository.load()) {
///   case Ok<Data>(:final value):
///     use(value);
///   case Error<Data>(:final error):
///     report(error);
/// }
/// ```
sealed class Result<T> {
  const Result();

  /// A successful result carrying [value].
  const factory Result.ok(T value) = Ok<T>._;

  /// A failed result carrying [error].
  const factory Result.error(Exception error) = Error<T>._;
}

/// A successful [Result].
final class Ok<T> extends Result<T> {
  const Ok._(this.value);

  /// The value returned by the operation.
  final T value;

  @override
  String toString() => 'Result<$T>.ok($value)';
}

/// A failed [Result].
final class Error<T> extends Result<T> {
  const Error._(this.error);

  /// The exception that caused the operation to fail.
  final Exception error;

  @override
  String toString() => 'Result<$T>.error($error)';
}
