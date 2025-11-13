import 'package:flutter/material.dart';

class ResponsiveHelper {
  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.shortestSide >= 600;
}
