import '../utils/result.dart';

/// A single piece of application behaviour, invoked as a function.
abstract interface class UseCase<T, P> {
  /// Runs the use case with [params].
  Future<Result<T>> call(P params);
}

/// A [UseCase] that needs no input.
abstract interface class UseCaseNoParams<T> {
  /// Runs the use case.
  Future<Result<T>> call();
}

/// A use case that exposes a continuous stream rather than a one-shot result.
abstract interface class StreamUseCase<T> {
  /// Subscribes to the underlying source.
  Stream<T> call();
}
