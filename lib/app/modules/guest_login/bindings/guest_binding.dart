import 'package:get/get.dart';

import '../controllers/guest_login_controller.dart';

class GuestBinding extends Bindings {
  @override
  void dependencies() {
    // You can initialize your GuestLoginController here if needed
    Get.lazyPut<GuestLoginController>(() => GuestLoginController());
  }
}
