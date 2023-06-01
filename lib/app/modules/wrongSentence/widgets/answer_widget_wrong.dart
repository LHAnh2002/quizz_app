import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizz_app/app/common/values/app_color.dart';
import 'package:quizz_app/app/common/values/style/app_text_style.dart';
import 'package:quizz_app/app/modules/wrongSentence/controller/wrong_controller.dart';

enum AnswerStatusWrong { correct, wrong, answered, nottanswered }

class AnswerWidgetWrong extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final VoidCallback onTap;
  const AnswerWidgetWrong(
      {Key? key,
      required this.answer,
      this.isSelected = false,
      required this.onTap})
      : super(key: key);
  Widget getImage(dynamic answer) => answer.startsWith('https://')
      ? Image.network(
          answer,
        )
      : Text(
          '$answer',
          style: AppTextStyle.semiBoldMediumStyle.copyWith(),
        );
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(left: 13, right: 13, top: 9, bottom: 9).r,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2.0,
                color: isSelected ? AppColors.kButtonColor : AppColors.white,
              ),
              borderRadius: BorderRadius.all(const Radius.circular(7.0).r),
              color: const Color.fromARGB(255, 245, 245, 245),
            ),
            child: getImage(answer),
          ),
        ),
        SizedBox(width: 0.0, height: 10.h),
      ],
    );
  }
}

class CorrectWidgetWrong extends StatelessWidget {
  const CorrectWidgetWrong({Key? key, required this.answer}) : super(key: key);
  final String answer;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(left: 13, right: 13, top: 9, bottom: 9).r,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2.0,
              color: AppColors.primaryLighColorLight.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.all(const Radius.circular(7.0).r),
            color: AppColors.primaryLighColorLight.withOpacity(0.1),
          ),
          child: Text(
            answer,
            style: AppTextStyle.semiBoldMediumStyle.copyWith(
              color: AppColors.primaryLighColorLight,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 0.0, height: 10.h),
      ],
    );
  }
}

class WrongWidgetWrong extends StatelessWidget {
  const WrongWidgetWrong({Key? key, required this.answer}) : super(key: key);
  final String answer;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(left: 13, right: 13, top: 9, bottom: 9).r,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2.0,
              color: AppColors.kTabarTextColor.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.all(const Radius.circular(7.0).r),
            color: AppColors.kTabarTextColor.withOpacity(0.1),
          ),
          child: Text(
            answer,
            style: AppTextStyle.semiBoldMediumStyle.copyWith(
              color: AppColors.kTabarTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 0.0, height: 10.h),
      ],
    );
  }
}

class NotAnswerWidgetWrong extends GetView<WrongController> {
  const NotAnswerWidgetWrong({Key? key, required this.answer})
      : super(key: key);
  final String answer;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(left: 13, right: 13, top: 9, bottom: 9).r,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2.0,
              color: AppColors.kTabarTextColor.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.all(const Radius.circular(7.0).r),
            color: AppColors.kTabarTextColor.withOpacity(0.1),
          ),
          child: Text(
            answer,
            style: AppTextStyle.semiBoldMediumStyle.copyWith(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 0.0, height: 10.h),
      ],
    );
  }
}
