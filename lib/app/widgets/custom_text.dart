import 'package:flutter/material.dart';

Widget CustomText({
  required String text,
  double fontSize = 16,
  FontWeight fontWeight = FontWeight.normal,
  Color color = Colors.black,
  TextAlign textAlign = TextAlign.start,
  TextOverflow overflow = TextOverflow.ellipsis,
  int? maxLines,
  TextStyle? style,
}) {
  return Text(
    text,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color),
  );
}
