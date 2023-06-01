import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizz_app/app/common/controller/firebase_ref/loading_status.dart';
import 'package:quizz_app/app/common/values/app_color.dart';
import 'package:quizz_app/app/common/values/style/app_text_style.dart';
import 'package:quizz_app/app/common/values/style/string.dart';
import 'package:quizz_app/app/common/widgets/count_down_timer.dart';
import 'package:quizz_app/app/modules/home/view/text_overview_screen.dart';
import 'package:quizz_app/app/modules/randomTopic/controller/randomTopic_controller.dart';
import 'package:quizz_app/app/modules/randomTopic/loading/random_topic_loading.dart';
import 'package:quizz_app/app/modules/randomTopic/widgets/background_decoration.dart';
import 'package:quizz_app/app/modules/randomTopic/widgets/custom_app_bar.dart';
import 'package:quizz_app/app/modules/widgets/answer_widget.dart';
import 'package:quizz_app/app/modules/widgets/drum_widget.dart';
import 'package:quizz_app/app/modules/widgets/error_widget.dart';

class RandomTopicView extends GetView<RandomTopicController> {
  const RandomTopicView({Key? key}) : super(key: key);

  static const String routesname = '/randomtopic';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
          leading: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1).r,
              decoration: ShapeDecoration(
                shape: StadiumBorder(
                  side: BorderSide(color: AppColors.white, width: 2.w),
                ),
              ),
              child: Obx(() => CountDownTimer(
                    time: controller.time.value,
                    color: Colors.white,
                  ))),
          showActionIcon: true,
          titleWidget: Obx(
            () => Text(
              'Câu ${(controller.currentIndex.value + 1).toString().padLeft(2, '0')}',
              style: AppTextStyle.semiBoldMediumStyle
                  .copyWith(color: AppColors.white),
            ),
          )),
      body: BackgroundDecoration(
        child: Obx(
          () => Column(
            children: [
              if (controller.loadingStatus.value == LoadingStatus.drum)
                const DrumWidgets(),
              if (controller.loadingStatus.value == LoadingStatus.error)
                const ErrorWidgets(),
              if (controller.loadingStatus.value == LoadingStatus.loading)
                const RandomTopicLoading(),
              if (controller.loadingStatus.value == LoadingStatus.completed)
                Expanded(
                  child: SafeArea(
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
                            padding: const EdgeInsets.only(
                                    left: 25, right: 25, top: 20)
                                .r,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
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
                                  SizedBox(width: 0.0, height: 20.h),
                                  GetBuilder<RandomTopicController>(
                                    id: 'answers_list',
                                    builder: (context) {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: controller.currentQuestion
                                            .value!.answers.length,
                                        itemBuilder: (context, answerIndex) {
                                          final answer = controller
                                              .currentQuestion
                                              .value!
                                              .answers[answerIndex];
                                          final String identifierText =
                                              '${answer.identifier}';
                                          final String answersText =
                                              '${answer.answer}';
                                          return AnswerWidget(
                                            onTap: () =>
                                                controller.selectedAnswer(
                                                    answer.identifier),
                                            answer: answersText,
                                            isSelected: answer.identifier ==
                                                controller.currentQuestion
                                                    .value!.selectedAnswer,
                                            identifier: identifierText,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              SizedBox(
                width: double.infinity,
                height: 60.h,
                child: ColoredBox(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8).r,
                    child: Row(
                      children: [
                        Visibility(
                          visible: controller.isFirstQuestion,
                          child: SizedBox(
                            width: 55.w,
                            height: 55.h,
                            child: InkWell(
                              onTap: () => controller.previousQuestion(),
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                size: 23.sp,
                                color: AppColors.kButtonColor,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Visibility(
                              visible: controller.loadingStatus.value ==
                                  LoadingStatus.completed,
                              child: InkWell(
                                  onTap: () {
                                    controller.isLastQuestion
                                        ? Get.toNamed(
                                            TextOverviewScreen.routeName)
                                        : controller.nextQuestion();
                                  },
                                  child: Text(
                                    controller.isLastQuestion
                                        ? Strings.complete
                                        : Strings.next,
                                    style: AppTextStyle.semiBoldMediumStyle
                                        .copyWith(
                                            color: AppColors.kButtonColor),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
