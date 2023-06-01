import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizz_app/app/common/values/app_color.dart';
import 'package:quizz_app/app/common/values/style/app_text_style.dart';

class AllQuestionsWidgets extends StatelessWidget {
  const AllQuestionsWidgets(
      {Key? key, required this.title, required this.onTap})
      : super(key: key);
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 150.h,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 15, right: 15, top: 9, bottom: 9).r,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: const Color.fromARGB(255, 233, 88, 88),
        ),
        borderRadius: BorderRadius.all(const Radius.circular(7.0).r),
        color: const Color.fromARGB(255, 245, 245, 245),
      ),
      child: InkWell(
        onTap: onTap,
        child: Text(
          title,
          style: AppTextStyle.semiBoldMediumStyle.copyWith(
            color: AppColors.black,
            fontSize: 18.sp,
          ),
        ),
      ),
    );
  }
}
