import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizz_app/app/common/values/app_color.dart';
import 'package:quizz_app/app/common/values/style/app_text_style.dart';
import 'package:quizz_app/app/modules/allQuestions/controller/all_question_word_controller.dart';
import 'package:quizz_app/app/modules/allQuestions/widgets/answer_widget_word.dart';
import 'package:quizz_app/app/modules/randomTopic/controller/randomTopic_controller.dart';
import 'package:quizz_app/app/modules/randomTopic/widgets/background_decoration.dart';
import 'package:quizz_app/app/modules/randomTopic/widgets/custom_app_bar.dart';
import 'package:quizz_app/app/modules/widgets/answer_widget.dart';
import 'package:quizz_app/app/modules/widgets/result_screen.dart';

class AnswerCheckWordScreen extends GetView<AllQuestionWordController> {
  const AnswerCheckWordScreen({Key? key}) : super(key: key);
  static const String routeName = '/answerwordcheck';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        titleWidget: Obx(
          () => Text(
            'Câu ${(controller.currentIndex.value + 1).toString().padLeft(2, '0')}',
            style: AppTextStyle.semiBoldMediumStyle.copyWith(
              color: AppColors.white,
              // fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
        ),
        showActionIcon: true,
        onMenuActionTap: () {
          Get.toNamed(ResultScreen.rountName);
        },
      ),
      // ignore: prefer_const_constructors
      body: BackgroundDecoration(
          child: Obx(() => Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 226, 226),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Image.asset(
                              "assets/images/main_top.png",
                              width: 500.w * 0.3,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: Image.asset(
                              "assets/images/main_bottom.png",
                              width: 300.w * 0.3,
                            ),
                          ),
                          SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(
                                    top: 20, left: 20, right: 20)
                                .r,
                            child: Column(
                              children: <Widget>[
                                Text(
                                  controller.currentQuestion.value!.question,
                                  style: AppTextStyle.semiBoldMediumStyle
                                      .copyWith(fontSize: 16.sp),
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(width: 0.0, height: 10.h),
                                controller.currentQuestion.value!.imageUrl !=
                                            null &&
                                        controller
                                            .currentQuestion.value!.imageUrl!
                                            .startsWith('https://')
                                    ? SizedBox(
                                        width: double.infinity,
                                        height: 200.h,
                                        child: FadeInImage(
                                          image: NetworkImage(controller
                                              .currentQuestion
                                              .value!
                                              .imageUrl!),
                                          placeholder: const AssetImage(
                                            "assets/images/logo_app.png",
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                SizedBox(width: 0.0, height: 10.h),
                                GetBuilder<RandomTopicController>(
                                  id: 'answer_review_list',
                                  builder: (_) {
                                    return ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (_, index) {
                                        final answer = controller
                                            .currentQuestion
                                            .value!
                                            .answers[index];
                                        final selectedAnswer = controller
                                            .currentQuestion
                                            .value!
                                            .selectedAnswer;
                                        final correctAnswer = controller
                                            .currentQuestion
                                            .value!
                                            .correctAnswer;
                                        final String identifierText =
                                            '${answer.identifier}';
                                        final String answersText =
                                            '${answer.answer}';

                                        if (correctAnswer == selectedAnswer &&
                                            answer.identifier ==
                                                selectedAnswer) {
                                          return CorrectWidgetWord(
                                            answer: answersText,
                                            identifier: identifierText,
                                          );
                                        } else if (selectedAnswer == null) {
                                          return NotAnswerWidgetWord(
                                            answer: answersText,
                                            identifier: identifierText,
                                          );
                                        } else if (correctAnswer !=
                                                selectedAnswer &&
                                            answer.identifier ==
                                                selectedAnswer) {
                                          return WrongWidgetWord(
                                            answer: answersText,
                                            identifier: identifierText,
                                          );
                                        } else if (correctAnswer ==
                                            answer.identifier) {
                                          return CorrectWidgetWord(
                                            answer: answersText,
                                            identifier: identifierText,
                                          );
                                        }
                                        return AnswerWidgetWord(
                                          onTap: () {},
                                          answer: answersText,
                                          identifier: identifierText,
                                          isSelected: false,
                                        );
                                      },
                                      separatorBuilder: (_, index) {
                                        return SizedBox(
                                            width: 0.0, height: 10.h);
                                      },
                                      itemCount: controller.currentQuestion
                                          .value!.answers.length,
                                    );
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ))),
    );
  }
}
