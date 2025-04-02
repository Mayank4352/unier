import 'package:vosk_flutter_2/vosk_flutter_2.dart';

class SpeechService {
  VoskFlutterPlugin? _vosk;
  Recognizer? _recognizer;
  Model? _model;

  Future<void> initialize() async {
    _vosk = VoskFlutterPlugin.instance();
    // Load and create model
    final modelPath = await ModelLoader()
        .loadFromAssets('assets/models/vosk-model-small-en-in-0.4.zip');
    _model = await _vosk?.createModel(modelPath);

    // Create recognizer
    _recognizer = await _vosk?.createRecognizer(
      model: _model!,
      sampleRate: 16000,
    );
  }

//   Future<String> transcribeAudioStream(Stream<List<int>> audioStream) async {
//   try {
//     if (_recognizer == null) {
//       throw Exception('Recognizer not initialized');
//     }

//     await for (final chunk in audioStream) {
//       // Process audio chunk using the recognizer
//       final isAccepted = await _recognizer!.acceptWaveform(chunk);
//       if (!isAccepted) {
//         print('Audio chunk not accepted');
//       }
//     }

//     // Get final result after processing all audio
//     final result = await _recognizer!.result();
//     return result?.text ?? '';
//   } catch (error) {
//     print('Transcription error: $error');
//     return '';
//   }
// }

  void dispose() {
    _recognizer?.dispose();
    _model?.dispose();
    _vosk = null;
  }
}
