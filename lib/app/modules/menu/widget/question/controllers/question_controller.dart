import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionPaperPopupController extends GetxController {
  var selectedType = Rxn<String>();
  var selectedGrade = Rxn<String>();
  var selectedSubject = Rxn<String>();
  var selectedChapter = Rxn<String>();

  var difficulty = "Easy".obs;

  var questionFrom = "Own AI".obs;

  var selectedQuestionType = Rxn<String>();

  TextEditingController totalMarks = TextEditingController();

  var timeDuration = false.obs;

  var selectedDate = Rxn<DateTime>();
  var startTime = Rxn<TimeOfDay>();
  var endTime = Rxn<TimeOfDay>();
}
