import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primarySwatch: AppColors.primarySwatch,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      elevation: 1,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black87),
      titleTextStyle: AppTextStyles.appBarTitle,
    ),
  );
}
