import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizz_app/app/common/values/app_color.dart';

class ThemeController extends GetxController {
  final ThemeData _darkTheme = DarkTheme().buildDarkTheme();
  final ThemeData _lightTheme = LightTheme().buildLightTheme();

  ThemeData get darkTheme => _darkTheme;
  ThemeData get lightTheme => _lightTheme;
}
