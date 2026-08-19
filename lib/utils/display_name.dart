/// Name-shaping helpers shared by the domain models.
extension DisplayName on String {
  /// The first word of a full name, used by the greeting.
  ///
  /// Returns the whole string when it holds a single word.
  String get givenName {
    final trimmed = trim();
    if (trimmed.isEmpty) return trimmed;
    return trimmed.split(RegExp(r'\s+')).first;
  }

  /// Up to two uppercase initials, e.g. `Angle Operator` -> `AO`.
  ///
  /// Falls back to the first character of a single-word name, and to an empty
  /// string when there is nothing to take an initial from.
  String get initials {
    final words = trim()
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .toList(growable: false);
    return switch (words) {
      [] => '',
      [final only] => _firstLetter(only),
      [final first, ..., final last] => _firstLetter(first) + _firstLetter(last),
    };
  }

  static String _firstLetter(String word) =>
      word.isEmpty ? '' : word.substring(0, 1).toUpperCase();
}
