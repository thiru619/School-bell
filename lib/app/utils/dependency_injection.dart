import 'package:get/get.dart';

import '../modules/chat/bindings/chat_binding.dart';

class DependencyInjection {
  static void init() async {
    Get.put<GetConnect>(GetConnect(), permanent: true);
    ChatBinding().dependencies();
  }
}
