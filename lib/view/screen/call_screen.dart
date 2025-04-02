import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unier/livekit/livekit_service.dart';
import 'package:unier/livekit/speech%20service.dart';
import 'package:unier/livekit/tts_service.dart';

class CallScreen extends ConsumerStatefulWidget {
  const CallScreen({super.key});

  @override
  ConsumerState<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends ConsumerState<CallScreen> {
  final _livekitService = LiveKitService();
  final _speechService = SpeechService();
  final _ttsService = TTSService();
  
  String _transcribedText = '';
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _speechService.initialize();
    await _ttsService.initialize();
    // Add your LiveKit URL and token here
    await _livekitService.connect('your-livekit-url', 'your-token');
    _startAudioStream();
  }

  Future<void> _startAudioStream() async {
    final audioTrack = await _livekitService.publishAudioTrack();
    if (audioTrack != null) {
      // Convert audio track to stream and transcribe
      // Note: You'll need to implement the conversion logic
    }
  }

  Future<void> _sendMessage() async {
    if (_textController.text.isNotEmpty) {
      await _ttsService.speak(_textController.text);
      // Send the synthesized audio to LiveKit
      _textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Call')),
      body: Column(
        children: [
          Expanded(
            child: Text(_transcribedText),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _livekitService.disconnect();
    _speechService.dispose();
    _textController.dispose();
    super.dispose();
  }
}