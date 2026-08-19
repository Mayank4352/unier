import '../../../../core/utils/result.dart';
import '../entities/phone_contact.dart';

// The device address book.
abstract interface class ContactsRepository {
  // Whether the app already holds the contacts permission.
  Future<bool> hasPermission();

  // Asks the OS for the contacts permission.
  Future<Result<void>> requestPermission();

  // Reads every contact, sorted by display name.
  Future<Result<List<PhoneContact>>> getContacts({bool withPhotos});

  // Opens the OS settings page, for a permanently denied permission.
  Future<void> openSystemSettings();
}
