import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizz_app/app/common/values/app_color.dart';
import 'package:quizz_app/app/common/values/style/app_text_style.dart';

class HomeButtonWidget extends StatelessWidget {
  const HomeButtonWidget(
      {Key? key,
      this.width = 60,
      this.ontap,
      required this.child,
      required this.text})
      : super(key: key);
  final Widget child;
  final double width;
  final VoidCallback? ontap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Stack(
        children: [
          Container(
            height: 150.h,
            width: 175.w,
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 9, bottom: 9).r,
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1.0,
                  color: const Color.fromARGB(255, 233, 88, 88),
                ),
                borderRadius: BorderRadius.all(const Radius.circular(7.0).r),
                color: const Color.fromARGB(255, 245, 245, 245)),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                child,
                SizedBox(width: 0.0, height: 5.h),
                Text(
                  text,
                  style: AppTextStyle.semiBoldMediumStyle.copyWith(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
