import 'package:get/get.dart';
import 'package:unier/view/screen/chat_screen.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatScreen());
  }
}
