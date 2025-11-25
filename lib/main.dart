import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/bindings/initial_binding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'School Bell',
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.initial,
      initialBinding: InitialBinding(),
      // theme: AppTheme.lightTheme,
      getPages: AppPages.routes,
    );
  }
}
