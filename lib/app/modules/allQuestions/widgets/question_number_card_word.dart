import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizz_app/app/common/values/app_color.dart';
import 'package:quizz_app/app/common/values/style/app_text_style.dart';
import 'package:quizz_app/app/modules/allQuestions/widgets/answer_widget_word.dart';
import 'package:quizz_app/app/modules/widgets/answer_widget.dart';

class QuestionNumberCardWord extends StatelessWidget {
  const QuestionNumberCardWord({
    Key? key,
    required this.index,
    required this.status,
    required this.ontap,
  }) : super(key: key);

  final int index;
  final AnswerStatusWord? status;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    Color _backgroudColor = AppColors.amaranth;
    switch (status) {
      case AnswerStatusWord.answered:
        _backgroudColor:
        Get.isDarkMode
            ? Theme.of(context).reactive
            : Theme.of(context).primaryColor;
        break;
      case AnswerStatusWord.correct:
        _backgroudColor = const Color.fromARGB(255, 58, 203, 114);
        break;
      case AnswerStatusWord.wrong:
        _backgroudColor = AppColors.kTabarTextColor;
        break;
      case AnswerStatusWord.nottanswered:
        _backgroudColor = Get.isDarkMode
            ? Colors.red.withOpacity(0.5)
            : Theme.of(context).primaryColor.withOpacity(0.1);
        break;
      default:
        _backgroudColor = AppColors.amaranth.withOpacity(0.1);
    }
    return InkWell(
      borderRadius: BorderRadius.circular(10).r,
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.all(10).r,
        decoration: BoxDecoration(
          color: _backgroudColor,
          borderRadius: BorderRadius.all(const Radius.circular(10).r),
        ),
        child: Center(
          child: Text(
            '$index',
            style: AppTextStyle.semiBoldMediumStyle.copyWith(
              color: status == AnswerStatusWord.nottanswered
                  ? Theme.of(context).primaryColor
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
