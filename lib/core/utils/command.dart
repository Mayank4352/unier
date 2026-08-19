import 'package:flutter/foundation.dart';

import '../error/failure.dart';
import 'result.dart';

/// An action with no arguments, executed by a [Command0].
typedef CommandAction0<T> = Future<Result<T>> Function();

/// An action with a single argument, executed by a [Command1].
typedef CommandAction1<T, A> = Future<Result<T>> Function(A argument);

/// Exposes the lifecycle of one asynchronous action to the view.
abstract class Command<T> extends ChangeNotifier {
  Command();

  bool _running = false;
  bool get running => _running;

  Result<T>? _result;

  Result<T>? get result => _result;
  Failure? get failure => _result?.failureOrNull;
  bool get hasError => _result is Err<T>;
  bool get completed => _result is Ok<T>;

  /// Drops the stored result so a handled error is not reported twice.
  void clearResult() {
    _result = null;
    notifyListeners();
  }

  Future<void> _execute(CommandAction0<T> action) async {
    if (_running) return;

    _result = null;
    _running = true;
    notifyListeners();

    try {
      _result = await action();
    } finally {
      _running = false;
      notifyListeners();
    }
  }
}

/// A [Command] that takes no arguments.
final class Command0<T> extends Command<T> {
  Command0(this._action);

  final CommandAction0<T> _action;

  /// Runs the action.
  Future<void> execute() => _execute(_action);
}

/// A [Command] that takes a single argument.
final class Command1<T, A> extends Command<T> {
  Command1(this._action);

  final CommandAction1<T, A> _action;

  /// Runs the action with [argument].
  Future<void> execute(A argument) => _execute(() => _action(argument));
}
