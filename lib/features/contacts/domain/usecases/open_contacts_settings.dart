import '../repositories/contacts_repository.dart';

/// Sends the person to the OS settings page to re-enable contacts access.
final class OpenContactsSettings {
  const OpenContactsSettings(this._repository);

  final ContactsRepository _repository;

  Future<void> call() => _repository.openSystemSettings();
}
