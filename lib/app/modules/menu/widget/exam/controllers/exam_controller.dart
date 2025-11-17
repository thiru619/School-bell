import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExamPopupController extends GetxController {
  // Dropdowns
  var selectedType = RxnString();
  var selectedGrade = RxnString();
  var selectedSubject = RxnString();
  var selectedChapter = RxnString();

  // Difficulty
  var difficulty = "Easy".obs;

  // Question From
  var questionFrom = "Own AI".obs;

  // Total Marks
  TextEditingController totalMarks = TextEditingController();

  // Time Duration Switch
  var timeDuration = false.obs;

  // Date
  var selectedDate = Rxn<DateTime>();

  // Times
  var startTime = Rxn<TimeOfDay>();
  var endTime = Rxn<TimeOfDay>();

  // Question Types (checkbox + inputs)
  var questionTypes = [
    {
      "name": "Choose the Correct Answer",
      "checked": false.obs,
      "questions": TextEditingController(),
      "marks": TextEditingController(),
    },
    {
      "name": "Fill in the Blanks",
      "checked": false.obs,
      "questions": TextEditingController(),
      "marks": TextEditingController(),
    },
    {
      "name": "True Or False",
      "checked": false.obs,
      "questions": TextEditingController(),
      "marks": TextEditingController(),
    },
    {
      "name": "Match the Following",
      "checked": false.obs,
      "questions": TextEditingController(),
      "marks": TextEditingController(),
    },
    {
      "name": "Paragraph Question",
      "checked": false.obs,
      "questions": TextEditingController(),
      "marks": TextEditingController(),
    },
  ].obs;
}
