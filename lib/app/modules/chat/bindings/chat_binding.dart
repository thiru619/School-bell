import 'package:get/get.dart';
import '../controllers/chat_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    // Register controller eagerly so it's available when the ChatView builds
    Get.put<ChatController>(ChatController());
  }
}
