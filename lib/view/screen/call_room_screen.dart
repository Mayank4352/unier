// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:livekit_client/livekit_client.dart' as lk;
// import 'package:unier/controllers/call_controller.dart';

// class CallRoomScreen extends GetView<CallController> {
//   const CallRoomScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Call Room'),
//         actions: [
//           Obx(() => IconButton(
//                 icon:
//                     Icon(controller.isMuted.value ? Icons.mic_off : Icons.mic),
//                 onPressed: () => controller.toggleMute(),
//               )),
//           IconButton(
//             icon: const Icon(Icons.call_end),
//             onPressed: () async {
//               await controller.endCall();
//               Get.back();
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Obx(() => ListView.builder(
//                   itemCount: controller.participants.length,
//                   itemBuilder: (context, index) {
//                     final participant =
//                         controller.participants[index].participant;
//                     final audioLevel =
//                         controller.audioLevels[participant.identity]?.level ??
//                             0.0;

//                     return ListTile(
//                       leading: CircleAvatar(
//                         child: Text(participant.identity[0]),
//                         backgroundColor: _getAudioLevelColor(audioLevel),
//                       ),
//                       title: Text(participant.identity),
//                       trailing: Icon(
//                         participant.isMicrophoneEnabled
//                             ? Icons.mic
//                             : Icons.mic_off,
//                       ),
//                     );
//                   },
//                 )),
//           ),

//           Obx(() => Container(
//                 padding: const EdgeInsets.all(8),
//                 color: _getStateColor(controller.connectionState.value),
//                 child: Text(
//                   controller.connectionState.value.toString().split('.').last,
//                   style: const TextStyle(color: Colors.white),
//                 ),
//               )),

//           Obx(() => controller.error.value.isNotEmpty
//               ? Container(
//                   padding: const EdgeInsets.all(8),
//                   color: Colors.red,
//                   child: Text(
//                     controller.error.value,
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                 )
//               : const SizedBox.shrink()),
//         ],
//       ),
//     );
//   }

//   Color _getAudioLevelColor(double level) {
//     if (level > 0.7) return Colors.green;
//     if (level > 0.3) return Colors.yellow;
//     return Colors.grey;
//   }

//   Color _getStateColor(lk.ConnectionState state) {
//     switch (state) {
//       case lk.ConnectionState.connected:
//         return Colors.green;
//       case lk.ConnectionState.connecting:
//       case lk.ConnectionState.reconnecting:
//         return Colors.orange;
//       default:
//         return Colors.grey;
//     }
//   }
// }
