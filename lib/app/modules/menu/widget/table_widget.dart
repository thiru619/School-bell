import 'package:flutter/material.dart';

import '../../../widgets/custom_text.dart';

Widget tableWidget({required List<Map<String, dynamic>> rows}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: DataTable(
        headingRowHeight: 50,
        dataRowHeight: 50,
        columnSpacing: 32,
        horizontalMargin: 20,
        columns: [
          DataColumn(label: CustomText(text: "S no")),
          DataColumn(label: CustomText(text: "Type")),
          DataColumn(label: CustomText(text: "Section")),
          DataColumn(label: CustomText(text: "Difficult type")),
          DataColumn(label: CustomText(text: "Ques From")),
          DataColumn(label: CustomText(text: "Total Marks")),
          DataColumn(label: CustomText(text: "Quest Mark")),
          DataColumn(label: CustomText(text: "Duration")),
          DataColumn(label: CustomText(text: "Date")),
          DataColumn(label: CustomText(text: "Timing")),
        ],
        rows: rows.map((row) {
          return DataRow(
            cells: [
              DataCell(CustomText(text: row["sno"].toString())),
              DataCell(CustomText(text: row["type"])),
              DataCell(CustomText(text: row["section"])),
              DataCell(CustomText(text: row["difficulty"])),
              DataCell(CustomText(text: row["from"])),
              DataCell(CustomText(text: row["total"].toString())),
              DataCell(CustomText(text: row["mark"].toString())),
              DataCell(CustomText(text: row["duration"])),
              DataCell(CustomText(text: row["date"])),
              DataCell(CustomText(text: row["time"])),
            ],
          );
        }).toList(),
      ),
    ),
  );
}
