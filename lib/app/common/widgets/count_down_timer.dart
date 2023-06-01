import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizz_app/app/common/values/app_color.dart';
import 'package:quizz_app/app/common/values/style/app_text_style.dart';

class CountDownTimer extends StatelessWidget {
  const CountDownTimer({Key? key, this.color, required this.time})
      : super(key: key);
  final Color? color;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.timer,
          size: 23.sp,
          color: color ?? AppColors.white,
        ),
        SizedBox(width: 5.w, height: 0.0),
        Text(time,
            style: AppTextStyle.semiBoldMediumStyle.copyWith(color: color)),
      ],
    );
  }
}
