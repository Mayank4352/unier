import 'dart:convert';
import 'dart:developer';

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unier/view/screen/auth_screen.dart';
import 'package:unier/view/value_providers/chat_provider.dart';
import 'package:unier/view/widget/chat_bubble.dart';
import 'package:unier/view/widget/dropdown.dart';
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
  SpeechService? speechService;
  bool isListening = false;
  bool isSpeaking = false;
  FlutterTts flutterTts = FlutterTts();

  Future speak(String text) async {
    await flutterTts.speak(text);
  }

  Future<void> changeLanguage(String language) async {
    log('Changing language to $language');

    if (vosk != null) {
      speechService!.dispose();
      recognizer!.dispose();
      await flutterTts.clearVoice();
      List<dynamic> langs = await flutterTts.getLanguages;
      log("language ${langs.toString()}");

      String? modelPath;

      if (language == 'english') {
        await flutterTts.setLanguage("en-IN");
        modelPath = 'assets/models/vosk-model-small-en-in-0.4.zip';
      } else if (language == 'hindi') {
        await flutterTts.setLanguage("hi-IN");
        modelPath = 'assets/models/vosk-model-small-hi-0.22.zip';
      } else if (language == 'gujarati') {
        await flutterTts.setLanguage("gu-IN");
        modelPath = 'assets/models/vosk-model-small-gu-0.42.zip';
      }
      String loadedPath = await ModelLoader().loadFromAssets(
          modelPath ?? 'assets/models/vosk-model-small-en-in-0.4.zip');
      model = await vosk!.createModel(loadedPath);
      recognizer = await vosk!.createRecognizer(
        model: model!,
        sampleRate: 16000,
      );
      speechService = await vosk!.initSpeechService(recognizer!);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    textFieldController = TextEditingController();
    chatScrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      vosk = VoskFlutterPlugin.instance();
      smallModel = await ModelLoader()
          .loadFromAssets('assets/models/vosk-model-small-en-in-0.4.zip');
      model = await vosk!.createModel(smallModel!);
      recognizer = await vosk!.createRecognizer(
        model: model!,
        sampleRate: 16000,
      );
      speechService = await vosk!.initSpeechService(recognizer!);
      await flutterTts.setEngine("com.google.android.tts");
      var langs = await flutterTts.getLanguages;
      log("language ${langs.toString()}");
      await flutterTts.setLanguage("en-IN");

      await flutterTts.setSpeechRate(0.5);
      await flutterTts.setVolume(1.0);
      await flutterTts.setPitch(1.0);
      setState(() {});
    });
  }

  @override
  void dispose() {
    textFieldController.dispose();
    chatScrollController.dispose();
    speechService!.dispose();
    super.dispose();
  }

  Future<void> saveMessageToFirestore(String message, bool isUser) async {
    try {
      await FirebaseFirestore.instance.collection('messages').add({
        'message': message,
        'isUser': isUser,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      log('Error saving message: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Messages> chat = ref.watch(chatsProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          LanguageDropdown(
            onLanguageSelected: (language) async {
              await changeLanguage(language.toLowerCase());
              print('Selected language: $language');
            },
          ),
          IconButton(
            onPressed: () async {
              await FirebaseUIAuth.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const AuthGate()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
        title: const Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                  "https://www.pngall.com/wp-content/uploads/12/Avatar-Profile-PNG-Image-File.png"),
            ),
          ],
        ),
      ),
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
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textFieldController,
                    style: const TextStyle(color: Colors.black),
                    textInputAction: TextInputAction.go,
                    onSubmitted: (value) async {
                      final message = textFieldController.text;
                      await saveMessageToFirestore(message, true);
                      ref
                          .read(chatsProvider.notifier)
                          .addMessage(Messages(message, true));
                      chatScrollController.animateTo(
                        chatScrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
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
                    if (textFieldController.text.isNotEmpty) {
                      final message = textFieldController.text;
                      await saveMessageToFirestore(message, true);
                      ref
                          .read(chatsProvider.notifier)
                          .addMessage(Messages(message, true));
                      chatScrollController.animateTo(
                        chatScrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                      log('Start Speaking');
                      await speak(message).whenComplete(() {
                        isSpeaking = false;
                        setState(() {});
                      });
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
                if (!isSpeaking) {
                  Map<String, dynamic> map = jsonDecode(partial);
                  if (map['partial'] != "") {
                    prev = map['partial'];
                  } else if (prev != "") {
                    saveMessageToFirestore(prev, false);
                    ref
                        .read(chatsProvider.notifier)
                        .addMessage(Messages(prev, false));
                    prev = '';
                  }
                  log(map.toString());
                  setState(() {});
                }
              });
              speechService!.onResult().forEach((result) {
                Map<String, dynamic> map = jsonDecode(result);
                log(map.toString());

                if (map.containsKey('text') && map['text'] != "") {
                  final spokenMessage = map['text'];
                  saveMessageToFirestore(spokenMessage, false);
                  ref
                      .read(chatsProvider.notifier)
                      .addMessage(Messages(spokenMessage, false));
                  setState(() {});
                }
              });
              await speechService!.start();
            } else {
              log("Stop Listening");
              await speechService!.stop();
              isListening = false;
              setState(() {});
            }
          },
          child: const Icon(Icons.mic, color: Colors.white),
        ),
      ),
    );
  }
}
