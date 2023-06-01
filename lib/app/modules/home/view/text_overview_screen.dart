import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizz_app/app/common/values/app_color.dart';
import 'package:quizz_app/app/common/values/style/app_text_style.dart';
import 'package:quizz_app/app/common/widgets/count_down_timer.dart';
import 'package:quizz_app/app/modules/randomTopic/controller/randomTopic_controller.dart';
import 'package:quizz_app/app/modules/randomTopic/view/random_topic_view.dart';
import 'package:quizz_app/app/modules/randomTopic/widgets/background_decoration.dart';
import 'package:quizz_app/app/modules/randomTopic/widgets/custom_app_bar.dart';
import 'package:quizz_app/app/modules/widgets/answer_widget.dart';
import 'package:quizz_app/app/modules/widgets/question_number_card.dart';

class TextOverviewScreen extends GetView<RandomTopicController> {
  const TextOverviewScreen({Key? key}) : super(key: key);

  static const String routeName = '/textoverview';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: controller.completedTest,
      ),
      body: BackgroundDecoration(
        child: Column(
          children: [
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
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 25, right: 25, top: 20).r,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const CountDownTimer(
                                color: AppColors.kButtonColor,
                                time: '',
                              ),
                              Obx(
                                () => Text(
                                  '${controller.time} Còn lại',
                                  style: AppTextStyle.semiBoldMediumStyle
                                      .copyWith(
                                          color: AppColors.kButtonColor,
                                          fontSize: 16.sp),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 0.0, height: 20.h),
                          Expanded(
                            child: GridView.builder(
                              itemCount: controller.questionsList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: Get.width ~/ 65,
                                childAspectRatio: 1,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                              itemBuilder: (_, index) {
                                final _question =
                                    controller.questionsList[index];
                                AnswerStatus _status = AnswerStatus.select;
                                final _selectedAnswer =
                                    _question.selectedAnswer;
                                final _correctAnswer = _question.correctAnswer;
                                if (_question.selectedAnswer == "") {
                                  _status = AnswerStatus.nottanswered;
                                }
                                return QuestionNumberCard(
                                  index: index + 1,
                                  status: _status,
                                  ontap: () {
                                    controller.jumpToQuestion(
                                      index,
                                      isGoBack: false,
                                    );
                                    Get.toNamed(RandomTopicView.routesname);
                                  },
                                );
                              },
                            ),
                          ),
                          Container(
                            width: 200.w,
                            height: 75.h,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 226, 226),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15).r,
                              child: InkWell(
                                onTap: () {
                                  controller.complete();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  padding: const EdgeInsets.only(
                                          left: 13,
                                          right: 13,
                                          top: 9,
                                          bottom: 9)
                                      .r,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        const Radius.circular(7.0).r),
                                    color: const Color.fromARGB(
                                        255, 245, 245, 245),
                                  ),
                                  child: Text(
                                    'Nộp bài',
                                    style: AppTextStyle.semiBoldMediumStyle
                                        .copyWith(
                                            color: AppColors.kButtonColor,
                                            fontSize: 18.sp),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
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
