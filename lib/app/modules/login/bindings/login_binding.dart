import 'package:get/get.dart';
import 'package:school_bell/app/modules/chat/controllers/chat_controller.dart';
import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
