import 'package:livekit_client/livekit_client.dart';

final roomOptions = RoomOptions(
  adaptiveStream: true,
  dynacast: true,
  defaultAudioCaptureOptions: AudioCaptureOptions(
  ),
);

final room = Room();



// await room.localParticipant.setMicrophoneEnabled(true);