import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_bell/app/modules/sign_in/views/sign_in_view.dart';
import '../../../widgets/custom_text.dart';
import '../../chat/bindings/chat_binding.dart';
import '../../chat/views/chat_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends StatelessWidget {
  final DashboardController controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText(text: 'Dashboard')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => CustomText(text: 'Counter: ${controller.count}')),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: controller.increment,
              child: CustomText(text: 'Increment'),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Manually bind chat then navigate
                ChatBinding().dependencies();
                Get.to(() => SignInView());
              },
              child: CustomText(text: 'Open Chat'),
            ),
          ],
        ),
      ),
    );
  }
}
