import 'package:flutter/material.dart';
import 'package:quizz_app/app/common/widgets/sub_theme_data_mixin.dart';

class AppColors {
  const AppColors._();

  static const Color kPrimaryColor = Color(0xFF3E68FF);
  static const Color mineShaft = Color(0xFF2B2B2B);
  static const Color doveGray = Color(0xFF646464);
  static const Color caribbeanGreen = Color(0xFF4CD964);
  static const Color amaranth = Color(0xFFea435d);
  static const Color kRangeDay = Color(0xFFFADFDF);
  static const Color kSelectedDay = Color(0xFFD75B5F);

  static const Color black = Colors.black;
  static const Color white = Colors.white;

  static const Color kButtonColor = Color.fromARGB(255, 227, 63, 96);
  static const Color kTabarTextColor = Color.fromARGB(255, 210, 34, 40);
  static const Color kBackgroundTextColor = Color(0xff66f1efef);
  static const Color kBlack56 = Color(0xFFB5B4B4);
  static const Color kBlackLight1 = Color(0xFF50555C);
  static const Color kBlackLight2 = Color(0xFF979797);
  static const Color kBlackDot = Color(0xFFE5E5E5);

  static const Color kBlackLight = Color(0xFF898A8D);
  static const Color kBlackBorder = Color(0xFF898A8D);
  static const Color kBlackText = Color(0xFFC4C4C4);
  static const Color kBackgroundColor = Color(0xFFF7F8FA);

  static const Color kIconEyesColor = Color(0xFF959595);
  static const Color kBlueLight = Color(0xFF3E68FF);
  static const Color kGreenChart = Color.fromARGB(255, 18, 22, 82);
  static const Color kGreen = Color(0xFF4CD964);
  static const Color kGreyChart = Color(0xFFCDD3E1);
  static const Color kBackgroundPercent = Color(0xFFE9E9E9);

  static const Color kGreenText = Color(0xFF4CD964);
  static const Color kYellowText = Color(0xFFFADA36);
  static const Color kPinkOpacity = Color(0xFFFDF1F4);

  //light theme
  static const Color primaryLighColorLight = Color(0xFF3ac3cb);
  static const Color primaryColorLight = Color(0xFFf85187);

  //dark theme
  static const Color primatryDarkColorDark = Color(0xFF2e3c62);
  static const Color primatryColorDark = Color(0xFF99ace1);
}

class LightTheme with SubThemeData {
  buildLightTheme() {
    final ThemeData systemLightTheme = ThemeData.light();
    return systemLightTheme.copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      iconTheme: getIconTheme(),
      textTheme: getTexttThemes().apply(
        bodyColor: AppColors.black,
        displayColor: AppColors.black,
      ),
    );
  }
}

class DarkTheme with SubThemeData {
  ThemeData buildDarkTheme() {
    final ThemeData systemDarkTheme = ThemeData.dark();
    return systemDarkTheme.copyWith(
      iconTheme: getIconTheme(),
      textTheme: getTexttThemes().apply(
        bodyColor: AppColors.white,
        displayColor: AppColors.white,
      ),
    );
  }
}
