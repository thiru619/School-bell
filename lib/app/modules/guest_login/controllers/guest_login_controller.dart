import 'package:get/get.dart';
import 'package:flutter/material.dart';

class GuestLoginController extends GetxController {
  String userType = "Student";

  List<String> grades = [
    "Grade VI",
    "Grade VII",
    "Grade VIII",
    "Grade IX",
    "Grade X",
    "Grade XI",
    "Grade XII",
  ];

  // For Teacher → multi-select
  List<String> selectedGrades = [];

  // For Student → single select
  String? selectedStudentGrade;

  TextEditingController pincodeController = TextEditingController();

  void changeUserType(String? value) {
    userType = value ?? "Student";

    // Reset selections
    selectedGrades.clear();
    selectedStudentGrade = null;

    update();
  }

  // Teacher multi-select toggle
  void toggleGradeSelection(String grade) {
    if (selectedGrades.contains(grade)) {
      selectedGrades.remove(grade);
    } else {
      selectedGrades.add(grade);
    }
    update();
  }

  // Student select
  void changeStudentGrade(String? value) {
    selectedStudentGrade = value;
    update();
  }
}
