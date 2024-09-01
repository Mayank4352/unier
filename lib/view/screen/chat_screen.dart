import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:unier/view/value_providers/chat_provider.dart';
import 'package:unier/view/widget/chat_bubble.dart';
import 'package:vosk_flutter_2/vosk_flutter_2.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  late TextEditingController textFieldController;
  late ScrollController chatScrollController;
  VoskFlutterPlugin? vosk;
  String? smallModel;
  Recognizer? recognizer;
  Model? model;
  TextEditingController textController = TextEditingController();
  SpeechService? speechService;
  bool isListening = false;
  FlutterTts flutterTts = FlutterTts();
  Future speak(String text) async {
    var result = await flutterTts.speak(text);
  }

  @override
  void initState() {
    super.initState();
    // Initialize controllers
    textFieldController = TextEditingController();
    chatScrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      vosk = VoskFlutterPlugin.instance();
      smallModel = await ModelLoader()
          .loadFromAssets('assets/models/vosk-model-small-en-in-0.4.zip');
      model = await vosk!.createModel(smallModel!);
      recognizer = await vosk!.createRecognizer(
        model: model!,
        sampleRate: 96000,
      );
      log('Creating Speech Service');
      speechService = await vosk!.initSpeechService(recognizer!);
      log('Speech Service Created');
      List<dynamic> languages = await flutterTts.getLanguages;
      log(languages.toString());
      await flutterTts.setLanguage("en-US");

      await flutterTts.setSpeechRate(0.6);

      await flutterTts.setVolume(1.0);

      await flutterTts.setPitch(0.5);
      setState(() {});
    });
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    textFieldController.dispose();
    chatScrollController.dispose();
    speechService!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Messages> chat = ref.watch(chatsProvider);
    // ref.read(chatsProvider.notifier).addMessage(Messages('Hello', false));

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
              },
            ),
          ),
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
                      chatScrollController.jumpTo(
                          chatScrollController.position.maxScrollExtent);
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    ref.read(chatsProvider.notifier).clear();
                  },
                  tooltip: 'Delete Chat History',
                  icon: const Icon(Icons.delete),
                ),
                IconButton(
                  onPressed: () async {
                    if (textFieldController.text != "") {
                      ref
                          .read(chatsProvider.notifier)
                          .addMessage(Messages(textFieldController.text, true));
                      chatScrollController.jumpTo(
                          chatScrollController.position.maxScrollExtent);
                      log('Start Speaking');
                      if (isListening) {
                        await speechService!.stop().then((call) async {
                          await speak(textFieldController.text)
                              .then((call) async {
                            await speechService!.start();
                          });
                        });
                      } else {
                        await speak(textFieldController.text);
                      }

                      textFieldController.clear();
                    }
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: FloatingActionButton(
          onPressed: () async {
            if (!isListening) {
              log("Start Listening");
              isListening = true;
              setState(() {});
              String prev = '';
              speechService!.onPartial().forEach((partial) {
                Map<String, dynamic> map = jsonDecode(partial);
                if (map['partial'] != "") {
                  prev = map['partial'];
                } else if (prev != "") {
                  ref
                      .read(chatsProvider.notifier)
                      .addMessage(Messages(prev, false));
                  prev = '';
                }

                log(map.toString());
                setState(() {});
              });
              speechService!.onResult().forEach((result) => () {
                    Map<String, dynamic> map = jsonDecode(result);
                    // textController.text = map['text'] ?? '';
                    log(map.toString());
                    setState(() {});
                  });
              await speechService!.start();
            } else {
              log("Stop Listening");

              await speechService!.stop();
              isListening = false;
              setState(() {});
              //await speechService!.dispose();
            }
          },
          child: const Icon(Icons.mic),
        ),
      ),
    );
  }
}
