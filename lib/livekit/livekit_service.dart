import 'package:livekit_client/livekit_client.dart';

class LiveKitService {
  Room? _room;
  LocalParticipant? _localParticipant;

  Future<void> connect(String url, String token) async {
    _room = Room();
    
    try {
      await _room?.connect(
        url,
        token,
        connectOptions: const ConnectOptions(
          autoSubscribe: true,
          // adaptiveStream: true,
        ),
      );
      
      _localParticipant = _room?.localParticipant;
    } catch (error) {
      print('Failed to connect to LiveKit: $error');
      rethrow;
    }
  }

  Future<LocalAudioTrack?> publishAudioTrack() async {
    try {
      final audioTrack = await LocalAudioTrack.create();
      await _localParticipant?.publishAudioTrack(audioTrack);
      return audioTrack;
    } catch (error) {
      print('Failed to publish audio track: $error');
      return null;
    }
  }

  void disconnect() {
    _room?.disconnect();
    _room = null;
  }
}