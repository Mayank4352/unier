import 'package:flutter/foundation.dart';

import 'result.dart';

/// An action with no arguments, executed by a [Command0].
typedef CommandAction0<T> = Future<Result<T>> Function();

/// An action with a single argument, executed by a [Command1].
typedef CommandAction1<T, A> = Future<Result<T>> Function(A argument);

/// Facilitates interaction with a view model.
///
/// A [Command] exposes the running/success/failure state of an asynchronous
/// action so the view can render progress and errors without the view model
/// having to hand-roll a flag for every action. Commands ignore re-entrant
/// calls while they are already [running].
abstract class Command<T> extends ChangeNotifier {
  Command();

  bool _running = false;

  /// Whether the action is currently in flight.
  bool get running => _running;

  Result<T>? _result;

  /// The most recent result, or `null` if the command has not completed.
  Result<T>? get result => _result;

  /// Whether the most recent run failed.
  bool get error => _result is Error;

  /// Whether the most recent run succeeded.
  bool get completed => _result is Ok;

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
