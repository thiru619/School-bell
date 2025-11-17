import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/menu_controller.dart';
import '../controllers/exam_controller.dart';

void showExamPopup(MenuPageController controller, BuildContext context) {
  final popup = Get.put(ExamPopupController());

  Get.dialog(
    AlertDialog(
      title: const Text("Create Online Exam"),
      content: SizedBox(
        width: 400,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TYPE
              Obx(
                () => DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: "Select Type"),
                  value: popup.selectedType.value,
                  items: ["Mid Term", "Quarterly", "Final"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => popup.selectedType.value = v,
                ),
              ),

              // GRADE
              Obx(
                () => DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Select Grade & Section",
                  ),
                  value: popup.selectedGrade.value,
                  items: ["6A", "7B", "8C"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => popup.selectedGrade.value = v,
                ),
              ),

              // SUBJECT
              Obx(
                () => DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Select Subject",
                  ),
                  value: popup.selectedSubject.value,
                  items: ["Math", "Science", "English"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => popup.selectedSubject.value = v,
                ),
              ),

              // CHAPTER
              Obx(
                () => DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Select Chapter",
                  ),
                  value: popup.selectedChapter.value,
                  items: ["Chapter 1", "Chapter 2", "Chapter 3"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => popup.selectedChapter.value = v,
                ),
              ),

              const SizedBox(height: 10),

              // DIFFICULTY
              const Text("Add Difficulty Type"),
              Obx(
                () => Row(
                  children: [
                    Radio(
                      value: "Easy",
                      groupValue: popup.difficulty.value,
                      onChanged: (v) => popup.difficulty.value = v!,
                    ),
                    const Text("Easy"),
                    Radio(
                      value: "Medium",
                      groupValue: popup.difficulty.value,
                      onChanged: (v) => popup.difficulty.value = v!,
                    ),
                    const Text("Medium"),
                    Radio(
                      value: "Hard",
                      groupValue: popup.difficulty.value,
                      onChanged: (v) => popup.difficulty.value = v!,
                    ),
                    const Text("Hard"),
                  ],
                ),
              ),

              // QUESTION FROM
              const SizedBox(height: 10),
              const Text("Question From"),
              Obx(
                () => Row(
                  children: [
                    Radio(
                      value: "Own AI",
                      groupValue: popup.questionFrom.value,
                      onChanged: (v) => popup.questionFrom.value = v!,
                    ),
                    const Text("Own AI"),
                    Radio(
                      value: "General AI",
                      groupValue: popup.questionFrom.value,
                      onChanged: (v) => popup.questionFrom.value = v!,
                    ),
                    const Text("General AI"),
                  ],
                ),
              ),

              // TOTAL MARKS
              TextField(
                controller: popup.totalMarks,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Total Marks"),
              ),

              const SizedBox(height: 15),
              const Text("Question Types"),

              // QUESTION TYPE CHECKBOX LIST
              Obx(
                () => Column(
                  children: popup.questionTypes.map((qt) {
                    return Row(
                      children: [
                        Obx(
                          () => Checkbox(
                            value: (qt["checked"] as RxBool).value,
                            onChanged: (v) =>
                                (qt["checked"] as RxBool).value = v!,
                          ),
                        ),

                        Expanded(child: Text(qt["name"].toString())),

                        // No. of Questions
                        SizedBox(
                          width: 50,
                          child: TextField(
                            controller:
                                (qt["questions"] as TextEditingController),
                            decoration: const InputDecoration(labelText: "Q"),
                            keyboardType: TextInputType.number,
                          ),
                        ),

                        const SizedBox(width: 5),

                        // Marks
                        SizedBox(
                          width: 50,
                          child: TextField(
                            controller: (qt["marks"] as TextEditingController),
                            decoration: const InputDecoration(labelText: "M"),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),

              // TIME DURATION
              Obx(
                () => SwitchListTile(
                  title: const Text("Time Duration"),
                  value: popup.timeDuration.value,
                  onChanged: (v) => popup.timeDuration.value = v,
                ),
              ),

              // DATE
              Obx(
                () => ListTile(
                  title: Text(
                    popup.selectedDate.value == null
                        ? "Select Date"
                        : popup.selectedDate.value!.toString().split(" ").first,
                  ),
                  trailing: const Icon(Icons.calendar_month),
                  onTap: () async {
                    popup.selectedDate.value = await showDatePicker(
                      context: context,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2035),
                      initialDate: DateTime.now(),
                    );
                  },
                ),
              ),

              // START TIME
              Obx(
                () => ListTile(
                  title: Text(
                    popup.startTime.value == null
                        ? "Start Time"
                        : popup.startTime.value!.format(context),
                  ),
                  trailing: const Icon(Icons.timer),
                  onTap: () async {
                    popup.startTime.value = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                  },
                ),
              ),

              // END TIME
              Obx(
                () => ListTile(
                  title: Text(
                    popup.endTime.value == null
                        ? "End Time"
                        : popup.endTime.value!.format(context),
                  ),
                  trailing: const Icon(Icons.timer_off),
                  onTap: () async {
                    popup.endTime.value = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),

        ElevatedButton(
          onPressed: () {
            controller.addNewRecord({
              "type": popup.selectedType.value,
              "grade": popup.selectedGrade.value,
              "subject": popup.selectedSubject.value,
              "chapter": popup.selectedChapter.value,
              "difficulty": popup.difficulty.value,
              "from": popup.questionFrom.value,
              "totalMarks": popup.totalMarks.text,
              "questionTypes": popup.questionTypes,
              "date":
                  popup.selectedDate.value?.toString().split(" ").first ?? "",
              "time":
                  "${popup.startTime.value?.format(context)} - ${popup.endTime.value?.format(context)}",
            });

            Get.back();
          },
          child: const Text("Save"),
        ),
      ],
    ),
  );
}
