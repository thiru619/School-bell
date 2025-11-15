import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_text.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText(text: 'Profile')),
      body: GetBuilder<ProfileController>(
        builder: (controller) => Center(
          child: Obx(() => CustomText(text: 'Name: \${controller.name}')),
        ),
      ),
    );
  }
}
