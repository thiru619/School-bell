import 'package:flutter/material.dart';
import 'package:school_bell/app/widgets/custom_text.dart';

PreferredSizeWidget appBar(String title) {
  return AppBar(title: CustomText(text: title));
}
