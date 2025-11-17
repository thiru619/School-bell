import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CrosswordPopupController extends GetxController {
  // Text fields
  TextEditingController crossword = TextEditingController();
  TextEditingController findWord = TextEditingController();
  TextEditingController totalMarks = TextEditingController();
  TextEditingController eachMark = TextEditingController();

  // Dropdowns
  RxnString selectedType = RxnString();
  RxnString selectedGrade = RxnString();
  RxnString selectedSubject = RxnString();
  RxnString selectedChapter = RxnString();

  // Radio buttons
  RxString difficulty = "Easy".obs;
  RxString questionFrom = "Own AI".obs;

  // Duration switch
  RxBool timeDuration = false.obs;

  // Date & Time
  Rxn<DateTime> selectedDate = Rxn();
  Rxn<TimeOfDay> startTime = Rxn();
  Rxn<TimeOfDay> endTime = Rxn();
}
