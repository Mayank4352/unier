// Name-shaping helpers shared by the domain models.
extension DisplayName on String {
  String get givenName {
    final trimmed = trim();
    if (trimmed.isEmpty) return trimmed;
    return trimmed.split(RegExp(r'\s+')).first;
  }

  String get initials {
    final words = trim()
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .toList(growable: false);
    return switch (words) {
      [] => '',
      [final only] => _firstLetter(only),
      [final first, ..., final last] =>
        _firstLetter(first) + _firstLetter(last),
    };
  }

  static String _firstLetter(String word) =>
      word.isEmpty ? '' : word.substring(0, 1).toUpperCase();
}
