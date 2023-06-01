import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quizz_app/app/common/values/app_color.dart';
import 'package:quizz_app/app/common/values/app_image.dart';
import 'package:quizz_app/app/common/values/style/app_text_style.dart';
import 'package:quizz_app/app/common/values/style/string.dart';
import 'package:quizz_app/app/modules/home/controller/question_controller_extension.dart';
import 'package:quizz_app/app/modules/randomTopic/controller/randomTopic_controller.dart';
import 'package:quizz_app/app/modules/randomTopic/widgets/background_decoration.dart';
import 'package:quizz_app/app/modules/randomTopic/widgets/custom_app_bar.dart';
import 'package:quizz_app/app/modules/widgets/answer_check_screen.dart';
import 'package:quizz_app/app/modules/widgets/answer_widget.dart';
import 'package:quizz_app/app/modules/widgets/question_number_card.dart';

class ResultScreen extends GetView<RandomTopicController> {
  const ResultScreen({Key? key}) : super(key: key);

  static const String rountName = '/resultscreen';

  @override
  Widget build(BuildContext context) {
    // Color _textColor = Get.isDarkMode ? Colors.white : AppColors.amaranth;
    return Scaffold(
      // appBar:
      body: BackgroundDecoration(
        child: Column(
          children: [
            CustomAppBar(
              leading: SizedBox(width: 0.0, height: 80.h),
              title: controller.correctAnsweredQuestion,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
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
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 25, right: 25, top: 20).r,
                      child: Column(
                        children: [


                          Padding(
                            padding:
                                const EdgeInsets.only(top: 20, bottom: 5).r,
                            child: Text(
                              Strings.congratulations,
                              style: AppTextStyle.semiBoldMediumStyle.copyWith(
                                color: AppColors.kButtonColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.sp,
                              ),
                            ),
                          ),
                          Text(
                            'Bạn có ${controller.points} điểm',
                            style: AppTextStyle.semiBoldMediumStyle.copyWith(
                              color: AppColors.kButtonColor,
                              fontSize: 20.sp,
                            ),
                          ),
                          SizedBox(width: 0.0, height: 25.h),
                          Text(
                            Strings.dung,
                            style: AppTextStyle.semiBoldMediumStyle.copyWith(
                                // color: AppColors.kButtonColor,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(width: 0.0, height: 25.h),
                          Expanded(
                            child: GridView.builder(
                                itemCount: controller.questionsList.length,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: Get.width ~/ 65,
                                        childAspectRatio: 1,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8),
                                itemBuilder: (_, index) {
                                  final _question =
                                      controller.questionsList[index];
                                  AnswerStatus _status =
                                      AnswerStatus.nottanswered;
                                  final _selectedAnswer =
                                      _question.selectedAnswer;
                                  final _correctAnswer =
                                      _question.correctAnswer;
                                  if (_selectedAnswer == _correctAnswer) {
                                    _status = AnswerStatus.correct;
                                  } else if (_question.selectedAnswer == null) {
                                    _status = AnswerStatus.wrong;
                                  } else {
                                    _status = AnswerStatus.wrong;
                                  }
                                  return QuestionNumberCard(
                                    index: index + 1,
                                    status: _status,
                                    ontap: () {
                                      controller.jumpToQuestion(
                                        index,
                                        isGoBack: false,
                                      );
                                      Get.toNamed(AnswerCheckScreen.routeName);
                                    },
                                  );
                                }),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            ColoredBox(
              color: AppColors.white,
              child: Padding(
                padding: const EdgeInsets.all(15).r,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        controller.tryAgain();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 150.w,
                        padding: const EdgeInsets.all(10).r,
                        decoration: BoxDecoration(
                          color: AppColors.kBlackLight1,
                          borderRadius:
                              BorderRadius.all(const Radius.circular(10).r),
                        ),
                        child: Text(
                          "Thử lại",
                          style: AppTextStyle.semiBoldMediumStyle
                              .copyWith(color: AppColors.kButtonColor),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.saveTestResults();
                        controller.saveTestResultsTime();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 150.w,
                        padding: const EdgeInsets.all(10).r,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius:
                              BorderRadius.all(const Radius.circular(10).r),
                        ),
                        child: Text(
                          "Go Home",
                          style: AppTextStyle.semiBoldMediumStyle
                              .copyWith(color: AppColors.kButtonColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
