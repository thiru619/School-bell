import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/custom_text.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText(text: 'Dashboard')),
      body: GetBuilder<DashboardController>(
        builder: (controller) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() => CustomText(text: 'Counter: ${controller.count.value}')),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: controller.increment,
                child: CustomText(text: 'Increment'),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.chat);
                },
                child: CustomText(text: 'Open Chat'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
