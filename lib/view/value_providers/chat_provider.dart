import 'package:flutter_riverpod/flutter_riverpod.dart';

class Messages {
  String message;
  bool isCurrentUserAuthor;

  Messages(this.message, this.isCurrentUserAuthor);
}

class ChatsNotifier extends Notifier<List<Messages>> {
  @override
  List<Messages> build() {
    return [];
  }

  void addMessage(Messages message) {
    state = [...state, message];
  }

  void clear() {
    state = [];
  }
}

final chatsProvider = NotifierProvider<ChatsNotifier, List<Messages>>(() {
  return ChatsNotifier();
});
