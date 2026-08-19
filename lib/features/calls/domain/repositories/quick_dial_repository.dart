import '../../../../core/utils/result.dart';
import '../entities/quick_dial_entry.dart';

/// The people pinned to the home screen for one-tap calling.
abstract interface class QuickDialRepository {
  /// The pinned people, in the order they should be shown, capped at [limit].
  Future<Result<List<QuickDialEntry>>> getQuickDial({int? limit});
}
