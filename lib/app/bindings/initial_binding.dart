import 'package:get/get.dart';
import '../modules/chat/controllers/chat_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Eagerly register controllers used across the app to avoid null lookups
    if (!Get.isRegistered<ChatController>()) {
      Get.put<ChatController>(ChatController());
    }
  }
}
