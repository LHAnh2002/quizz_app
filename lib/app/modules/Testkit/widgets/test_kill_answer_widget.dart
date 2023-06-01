import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizz_app/app/common/values/app_color.dart';
import 'package:quizz_app/app/common/values/style/app_text_style.dart';
import 'package:quizz_app/app/modules/Testkit/controller/test_kill_question_controller.dart';
import 'package:quizz_app/app/modules/randomTopic/controller/randomTopic_controller.dart';

enum AnswerStatusTestKill { correct, wrong, answered, nottanswered, select }

class AnswerWidgetTestKill extends StatelessWidget {
  final String answer;
  final String identifier;
  final bool isSelected;
  final VoidCallback onTap;
  const AnswerWidgetTestKill({
    Key? key,
    required this.answer,
    this.isSelected = false,
    required this.onTap,
    required this.identifier,
  }) : super(key: key);
  Widget getImage(dynamic answer) => answer.startsWith('https://')
      ? Row(
          children: [
            Text(
              '$identifier. ',
              style: AppTextStyle.semiBoldMediumStyle.copyWith(),
            ),
            FadeInImage(
              image: NetworkImage(
                answer,
              ),
              placeholder: const AssetImage(
                "assets/images/logo_app.png",
              ),
              width: 30.w,
              height: 30.h,
            ),
          ],
        )
      : Text(
          '$identifier. $answer',
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

class CorrectWidgetTestKill extends StatelessWidget {
  const CorrectWidgetTestKill(
      {Key? key, required this.answer, required this.identifier})
      : super(key: key);
  final String answer;
  final String identifier;
  Widget getImage(dynamic answer) => answer.startsWith('https://')
      ? Row(
          children: [
            Text(
              '$identifier. ',
              style: AppTextStyle.semiBoldMediumStyle.copyWith(
                color: AppColors.primaryLighColorLight,
                fontWeight: FontWeight.bold,
              ),
            ),
            FadeInImage(
              image: NetworkImage(
                answer,
              ),
              placeholder: const AssetImage(
                "assets/images/logo_app.png",
              ),
              width: 30.w,
              height: 30.h,
            ),
          ],
        )
      : Text(
          '$identifier. $answer',
          style: AppTextStyle.semiBoldMediumStyle.copyWith(
            color: AppColors.primaryLighColorLight,
            fontWeight: FontWeight.bold,
          ),
        );
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
          child: getImage(answer),
        ),
        SizedBox(width: 0.0, height: 10.h),
      ],
    );
  }
}

class WrongWidgetTestKill extends StatelessWidget {
  const WrongWidgetTestKill(
      {Key? key, required this.answer, required this.identifier})
      : super(key: key);
  final String answer;
  final String identifier;
  Widget getImage(dynamic answer) => answer.startsWith('https://')
      ? Row(
          children: [
            Text(
              '$identifier. ',
              style: AppTextStyle.semiBoldMediumStyle.copyWith(
                color: AppColors.kTabarTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            FadeInImage(
              image: NetworkImage(
                answer,
              ),
              placeholder: const AssetImage(
                "assets/images/logo_app.png",
              ),
              width: 30.w,
              height: 30.h,
            ),
          ],
        )
      : Text(
          '$identifier. $answer',
          style: AppTextStyle.semiBoldMediumStyle.copyWith(
            color: AppColors.kTabarTextColor,
            fontWeight: FontWeight.bold,
          ),
        );
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
          child: getImage(answer),
        ),
        SizedBox(width: 0.0, height: 10.h),
      ],
    );
  }
}

class NotAnswerWidgetTestKill extends GetView<TestKillQuestionController> {
  const NotAnswerWidgetTestKill(
      {Key? key, required this.answer, required this.identifier})
      : super(key: key);
  final String answer;
  final String identifier;
  Widget getImage(dynamic answer) => answer.startsWith('https://')
      ? Row(
          children: [
            Text(
              '$identifier. ',
              style: AppTextStyle.semiBoldMediumStyle.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            FadeInImage(
              image: NetworkImage(
                answer,
              ),
              placeholder: const AssetImage(
                "assets/images/logo_app.png",
              ),
              width: 30.w,
              height: 30.h,
            ),
          ],
        )
      : Text(
          '$identifier. $answer',
          style: AppTextStyle.semiBoldMediumStyle.copyWith(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        );
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
          child: getImage(answer),
        ),
        SizedBox(width: 0.0, height: 10.h),
      ],
    );
  }
}
