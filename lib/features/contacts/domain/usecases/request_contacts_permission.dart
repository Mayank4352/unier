import '../../../../core/usecase/use_case.dart';
import '../../../../core/utils/result.dart';
import '../repositories/contacts_repository.dart';

// Asks the OS for permission to read the address book.
final class RequestContactsPermission implements UseCaseNoParams<void> {
  const RequestContactsPermission(this._repository);
  final ContactsRepository _repository;

  @override
  Future<Result<void>> call() => _repository.requestPermission();
}
