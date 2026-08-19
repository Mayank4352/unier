import 'package:flutter/foundation.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/utils/command.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/phone_contact.dart';
import '../../domain/usecases/get_contacts.dart';
import '../../domain/usecases/open_contacts_settings.dart';

// Backs the Contacts tab: the device address book, with a search filter.
class ContactsViewModel extends ChangeNotifier {
  ContactsViewModel({
    required GetContacts getContacts,
    required OpenContactsSettings openContactsSettings,
  }) : _getContacts = getContacts,
       _openContactsSettings = openContactsSettings {
    load = Command0<void>(_load)..addListener(notifyListeners);
  }

  static const bool _withPhotos = true;

  final GetContacts _getContacts;
  final OpenContactsSettings _openContactsSettings;

  late final Command0<void> load;

  List<PhoneContact> _contacts = const <PhoneContact>[];
  String _query = '';

  // Contacts matching the current query.
  List<PhoneContact> get contacts {
    final term = _query.trim().toLowerCase();
    if (term.isEmpty) return _contacts;
    return _contacts
        .where(
          (contact) =>
              contact.displayName.toLowerCase().contains(term) ||
              contact.phoneNumbers.any((number) => number.contains(term)),
        )
        .toList(growable: false);
  }

  String get query => _query;

  set query(String value) {
    if (value == _query) return;
    _query = value;
    notifyListeners();
  }

  // Set when the person has declined the contacts permission.
  PermissionFailure? get permissionFailure => load.failure is PermissionFailure
      ? load.failure! as PermissionFailure
      : null;

  Future<void> refresh() => load.execute();

  // Grants access, or opens settings when the denial is permanent.
  Future<void> resolvePermission() async {
    if (permissionFailure?.isPermanentlyDenied ?? false) {
      await _openContactsSettings();
      return;
    }
    await refresh();
  }

  Future<Result<void>> _load() async {
    final result = await _getContacts(_withPhotos);
    return switch (result) {
      Ok<List<PhoneContact>>(:final value) => () {
        _contacts = value;
        return const Result<void>.ok(null);
      }(),
      Err<List<PhoneContact>>(:final failure) => Result<void>.err(failure),
    };
  }

  @override
  void dispose() {
    load.dispose();
    super.dispose();
  }
}
