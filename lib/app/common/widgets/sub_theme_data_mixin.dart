import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizz_app/app/common/values/app_color.dart';

mixin SubThemeData {
  getTexttThemes() {
    return GoogleFonts.quicksandTextTheme(
      const TextTheme(
        bodyText1: TextStyle(fontWeight: FontWeight.w400),
        bodyText2: TextStyle(fontWeight: FontWeight.w400),
      ),
    );
  }

  getIconTheme() {
    return IconThemeData(color: AppColors.black, size: 16.sp);
  }
}
