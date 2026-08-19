import '../../../../core/usecase/use_case.dart';
import '../../../../core/utils/result.dart';
import '../entities/phone_contact.dart';
import '../repositories/contacts_repository.dart';

/// Reads the device address book, callable contacts first.
final class GetContacts implements UseCase<List<PhoneContact>, bool> {
  const GetContacts(this._repository);
  final ContactsRepository _repository;

  @override
  Future<Result<List<PhoneContact>>> call(bool withPhotos) async {
    final result = await _repository.getContacts(withPhotos: withPhotos);
    return result.map(
      (contacts) => contacts
          .where((contact) => contact.displayName.trim().isNotEmpty)
          .toList(growable: false),
    );
  }
}
