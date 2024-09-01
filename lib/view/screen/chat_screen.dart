import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unier/view/value_providers/chat_provider.dart';
import 'package:unier/view/widget/chat_bubble.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Messages> chat = ref.watch(chatsProvider);

    TextEditingController textFieldController = TextEditingController();
    ScrollController chatScrollController = ScrollController();
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                controller: chatScrollController,
                  itemCount: chat.length,
                  itemBuilder: (context, index) {
                    return ChatBubble(
                      text: chat[index].message,
                      isUser: chat[index].isCurrentUserAuthor,
                    );
                  })),
          Container(
            decoration: const BoxDecoration(color: Colors.white),
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: textFieldController,
                  style: const TextStyle(color: Colors.black),
                  textInputAction: TextInputAction.go,
                  onSubmitted: (value) async {
                    ref
                        .read(chatsProvider.notifier)
                        .addMessage(Messages(textFieldController.text, true));
                    chatScrollController
                        .jumpTo(chatScrollController.position.maxScrollExtent);
                  },
                )),
                IconButton(
                    onPressed: () {
                      ref.read(chatsProvider.notifier).clear();
                    },
                    tooltip: 'Delete Chat History',
                    icon: const Icon(Icons.delete)),
                IconButton(
                    onPressed: () {
                      ref
                          .read(chatsProvider.notifier)
                          .addMessage(Messages(textFieldController.text, true));
                      chatScrollController.jumpTo(
                          chatScrollController.position.maxScrollExtent);
                    },
                    icon: const Icon(Icons.send))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
