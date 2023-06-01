import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizz_app/app/common/values/app_color.dart';
import 'package:quizz_app/app/common/values/style/app_text_style.dart';
import 'package:quizz_app/app/common/values/style/string.dart';
import 'package:quizz_app/app/modules/allQuestions/controller/all_question_word_controller.dart';
import 'package:quizz_app/app/modules/allQuestions/view/word/all_questions_word.dart';
import 'package:quizz_app/app/modules/allQuestions/widgets/all_questions_widgets.dart';

class AllQuestionsView extends GetView<AllQuestionWordController> {
  const AllQuestionsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Column(
                children: [
                  SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        InkWell(
                          onTap: () => Get.back(),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 25.sp,
                          ),
                        ),
                        Text(
                          Strings.allquestions,
                          style: AppTextStyle.semiBoldMediumStyle.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.sp,
                          ),
                        ),
                        Obx(
                          () {
                            final selectedAnswer = controller
                                .currentQuestion.value?.selectedAnswer;
                            if (selectedAnswer != "") {
                              return InkWell(
                                onTap: () {
                                  
                                  controller.showDialogDelete();
                                },
                                child: Icon(
                                  Icons.delete_outline_outlined,
                                  color: Colors.black,
                                  size: 28.sp,
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 0.0, height: 25.h),
                  AllQuestionsWidgets(
                    title: "Bộ đề thi word",
                    onTap: () {
                      controller.loadData("1");
                      Get.toNamed(AllQuestionsWord.routesname);
                    },
                  ),
                  SizedBox(width: 0.0, height: 10.h),
                  AllQuestionsWidgets(
                    title: "Bộ đề thi excel",
                    onTap: () {
                      controller.loadData("5");
                      Get.toNamed(AllQuestionsWord.routesname);
                    },
                  ),
                  SizedBox(width: 0.0, height: 10.h),
                  AllQuestionsWidgets(
                    title: "Bộ đề thi powepoint",
                    onTap: () {
                      controller.loadData("4");
                      Get.toNamed(AllQuestionsWord.routesname);
                    },
                  ),
                  SizedBox(width: 0.0, height: 10.h),
                  AllQuestionsWidgets(
                    title: "Bộ đề thi tìm hiểu công nghệ thông tin",
                    onTap: () {
                      controller.loadData("2");
                      Get.toNamed(AllQuestionsWord.routesname);
                    },
                  ),
                  SizedBox(width: 0.0, height: 10.h),
                  AllQuestionsWidgets(
                    title: "Bộ đề thi internet",
                    onTap: () {
                      controller.loadData("3");
                      Get.toNamed(AllQuestionsWord.routesname);
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
