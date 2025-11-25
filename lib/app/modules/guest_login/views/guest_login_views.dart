import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:school_bell/app/modules/guest_login/controllers/guest_login_controller.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_textfield.dart';

class GuestLoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios_rounded),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: GetBuilder<GuestLoginController>(
          init: Get.put(GuestLoginController()),
          builder: (controller) {
            return LayoutBuilder(
              builder: (context, constraints) {
                bool isTablet = constraints.maxWidth > 600;

                return Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isTablet ? 500 : double.infinity,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),

                        Center(
                          child: Image.asset('assets/logo.jpeg', height: 120),
                        ),
                        const SizedBox(height: 20),

                        Center(
                          child: CustomText(
                            text: "GUEST LOGIN",
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(height: 30),

                        // USER TYPE (Teacher / Student)
                        const Text("Select", style: TextStyle(fontSize: 16)),
                        Row(
                          children: [
                            Radio<String>(
                              value: "Teacher",
                              groupValue: controller.userType,
                              onChanged: controller.changeUserType,
                            ),
                            const Text("Teacher"),
                            const SizedBox(width: 20),
                            Radio<String>(
                              value: "Student",
                              groupValue: controller.userType,
                              onChanged: controller.changeUserType,
                            ),
                            const Text("Student"),
                          ],
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          "Select Grade",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),

                        if (controller.userType == "Teacher")
                          Wrap(
                            spacing: 8,
                            children: controller.grades.map((grade) {
                              bool isSelected = controller.selectedGrades
                                  .contains(grade);
                              return FilterChip(
                                label: Text(grade),
                                selected: isSelected,
                                onSelected: (value) {
                                  controller.toggleGradeSelection(grade);
                                },
                              );
                            }).toList(),
                          ),

                        if (controller.userType == "Student")
                          DropdownButtonFormField<String>(
                            decoration: _fieldDecoration(),
                            hint: const Text("Select Grade"),
                            value: controller.selectedStudentGrade,
                            items: controller.grades
                                .map(
                                  (g) => DropdownMenuItem(
                                    value: g,
                                    child: Text(g),
                                  ),
                                )
                                .toList(),
                            onChanged: controller.changeStudentGrade,
                          ),

                        const SizedBox(height: 20),

                        // SCHOOL NAME
                        const Text("School Name"),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration: _fieldDecoration().copyWith(
                            hintText: "Enter school name",
                          ),
                        ),

                        const SizedBox(height: 20),

                        // PINCODE
                        const Text("Pincode"),
                        const SizedBox(height: 8),
                        CustomTextField(
                          context: context,
                          hint: "Enter pincode",
                          controller: controller.pincodeController,
                        ),

                        const SizedBox(height: 20),

                        // MOBILE
                        const Text("Mobile"),
                        const SizedBox(height: 8),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration: _fieldDecoration().copyWith(
                            hintText: "Enter mobile number",
                          ),
                        ),

                        const SizedBox(height: 20),

                        // OTP
                        const Text("OTP"),
                        const SizedBox(height: 8),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: _fieldDecoration().copyWith(
                            hintText: "Enter OTP",
                          ),
                        ),

                        const SizedBox(height: 40),

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5B2D91),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              Get.toNamed(Routes.chat);
                              Get.snackbar("Success", "Guest login submitted!");
                            },
                            child: const Text(
                              "Submit",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  InputDecoration _fieldDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );
  }
}
