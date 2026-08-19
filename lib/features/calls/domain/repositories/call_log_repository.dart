import '../../../../core/utils/result.dart';
import '../entities/call_record.dart';

// The history of calls placed and received.
abstract interface class CallLogRepository {
  // The most recent calls, newest first, capped at limit.
  Future<Result<List<CallRecord>>> getRecentCalls({int? limit});
}
