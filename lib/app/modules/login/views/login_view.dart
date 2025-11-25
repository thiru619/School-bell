import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_textfield.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<LoginController>(
        builder: (controller) => LayoutBuilder(
          builder: (context, constraints) {
            // For responsiveness
            bool isTablet = constraints.maxWidth > 600;

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isTablet
                        ? 500
                        : double.infinity, // Center for tablet
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/logo.jpeg', height: 120),
                      const SizedBox(height: 20),
                      CustomText(
                        text: 'LOGIN',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 40),

                      // Email
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          text: 'User ID',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),

                      CustomTextField(
                        context: context,
                        controller: controller.emailController,
                        hint: "Enter your user ID",
                        prefixIcon: Icons.email_outlined,
                      ),

                      const SizedBox(height: 20),

                      // Password
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          text: 'Password',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),

                      CustomTextField(
                        context: context,
                        controller: controller.passwordController,
                        hint: '********',
                        isPassword: true,
                        prefixIcon: Icons.lock_outline,
                      ),

                      const SizedBox(height: 30),

                      // Register Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5B2D91),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () async {
                            Get.offNamed(Routes.chat);
                          },
                          child: CustomText(
                            text: 'Login',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Divider
                      Row(
                        children: [
                          const Expanded(child: Divider(thickness: 1)),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: CustomText(text: 'Or'),
                          ),
                          const Expanded(child: Divider(thickness: 1)),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Google Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton.icon(
                          onPressed: () => Get.toNamed(Routes.guestLogin),

                          label: CustomText(
                            text: 'Guest Login',
                            fontSize: 16,
                            color: AppTheme.black,
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppTheme.violet),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Login Redirect
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     CustomText(
                      //       text: 'Already have an account? ',
                      //       color: Colors.black87,
                      //     ),
                      //     GestureDetector(
                      //       onTap: () {},
                      //       child: CustomText(
                      //         text: 'Login',
                      //         color: Colors.purple,
                      //         fontWeight: FontWeight.w600,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
