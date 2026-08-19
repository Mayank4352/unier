// The current time, behind an interface.
abstract interface class Clock {
  // The current local time.
  DateTime now();
}

// A Clock backed by the system clock.
final class SystemClock implements Clock {
  const SystemClock();

  @override
  DateTime now() => DateTime.now();
}

// A Clock frozen at a fixed instant, for tests.
final class FixedClock implements Clock {
  const FixedClock(this._instant);
  final DateTime _instant;

  @override
  DateTime now() => _instant;
}
