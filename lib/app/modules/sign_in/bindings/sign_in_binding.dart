import 'package:get/get.dart';
import 'package:school_bell/app/modules/chat/controllers/chat_controller.dart';
import '../controllers/sign_in_controller.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
  }
}
