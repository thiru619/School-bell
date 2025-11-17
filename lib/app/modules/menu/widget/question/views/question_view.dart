import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/menu_controller.dart';
import '../controllers/question_controller.dart';

void showQuestionPaperPopup(
  MenuPageController controller,
  BuildContext context,
) {
  final popup = Get.put(QuestionPaperPopupController());

  Get.dialog(
    AlertDialog(
      title: const Text("Question Paper Generation"),
      content: SizedBox(
        width: 420,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Select Type
              Obx(
                () => DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: "Select Type"),
                  value: popup.selectedType.value,
                  items: ["Type A", "Type B", "Type C"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => popup.selectedType.value = v,
                ),
              ),

              // Grade
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

              // Subject
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

              // Chapter
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

              // Difficulty
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Add Difficulty Type"),
              ),

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

              // Question From
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Question From"),
              ),

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

              // Total Marks
              TextField(
                controller: popup.totalMarks,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Total Marks"),
              ),

              const SizedBox(height: 10),

              // Question Type
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Question Type"),
              ),
              Obx(
                () => DropdownButtonFormField<String>(
                  decoration: const InputDecoration(),
                  value: popup.selectedQuestionType.value,
                  items:
                      [
                            "Choose the Correct Answer",
                            "Fill in the Blanks",
                            "True or False",
                            "Match the Following",
                            "Short Answer Question",
                            "Long Answer Question",
                          ]
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                  onChanged: (v) => popup.selectedQuestionType.value = v,
                ),
              ),

              const SizedBox(height: 10),

              // Duration Switch
              Obx(
                () => SwitchListTile(
                  title: const Text("Time Duration"),
                  value: popup.timeDuration.value,
                  onChanged: (v) => popup.timeDuration.value = v,
                ),
              ),

              // Date
              Obx(
                () => ListTile(
                  title: Text(
                    popup.selectedDate.value == null
                        ? "Select Date"
                        : popup.selectedDate.value!.toString().split(" ").first,
                  ),
                  trailing: Icon(Icons.calendar_today),
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

              // Start Time
              Obx(
                () => ListTile(
                  title: Text(
                    popup.startTime.value == null
                        ? "Start Time"
                        : popup.startTime.value!.format(context),
                  ),
                  trailing: Icon(Icons.timer),
                  onTap: () async {
                    popup.startTime.value = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                  },
                ),
              ),

              // End Time
              Obx(
                () => ListTile(
                  title: Text(
                    popup.endTime.value == null
                        ? "End Time"
                        : popup.endTime.value!.format(context),
                  ),
                  trailing: Icon(Icons.timer_off),
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
              "sno": controller.originalData.length + 1,
              "type": popup.selectedType.value ?? "",
              "section": popup.selectedGrade.value ?? "",
              "subject": popup.selectedSubject.value ?? "",
              "chapter": popup.selectedChapter.value ?? "",

              "difficulty": popup.difficulty.value,
              "from": popup.questionFrom.value,

              "total_marks": int.tryParse(popup.totalMarks.text) ?? 0,
              "question_type": popup.selectedQuestionType.value ?? "",

              "duration": popup.timeDuration.value ? "Yes" : "No",
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
