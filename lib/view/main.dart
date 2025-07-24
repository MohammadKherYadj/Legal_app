import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_app/control/local/locale.dart';
import 'package:legal_app/control/local/localeController.dart';
import 'package:legal_app/view/auth/singin.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(MyLocaleController());
    return GetMaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xffffcf40),
          brightness: Brightness.light,
        ),
      ),
      locale: Get.deviceLocale,
      translations: MyLocale(),
      home: const SignIn(),
    );
  }
}
