/// The error half of a [Result].
sealed class Failure implements Exception {
  const Failure(this.message, {this.cause, this.stackTrace});
  final String message;
  final Object? cause;
  final StackTrace? stackTrace;

  @override
  String toString() => '$runtimeType: $message';
}

/// The device could not reach a remote service.
final class NetworkFailure extends Failure {
  const NetworkFailure(super.message, {super.cause, super.stackTrace});
}

/// Sign-in failed, or the session is not valid.
final class AuthFailure extends Failure {
  const AuthFailure(
    super.message, {
    this.wasCancelled = false,
    super.cause,
    super.stackTrace,
  });

  final bool wasCancelled;
}

/// The user declined an OS permission the feature needs.
final class PermissionFailure extends Failure {
  const PermissionFailure(
    super.message, {
    this.isPermanentlyDenied = false,
    super.cause,
    super.stackTrace,
  });

  final bool isPermanentlyDenied;
}

/// Local storage could not be read or written.
final class CacheFailure extends Failure {
  const CacheFailure(super.message, {super.cause, super.stackTrace});
}

/// Anything that was not anticipated.
final class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message, {super.cause, super.stackTrace});
}
