import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizz_app/app/common/values/style/string.dart';
import 'package:quizz_app/app/modules/Testkit/view/test_kit_view.dart';
import 'package:quizz_app/app/modules/Tips/view/tips_view.dart';
import 'package:quizz_app/app/modules/chatgpt/view/chat_gpt_view.dart';
import 'package:quizz_app/app/modules/home/controller/quesition_image_controller.dart';
import 'package:quizz_app/app/modules/review/view/review_view.dart';
import 'package:quizz_app/app/modules/widgets/home_button_widget.dart';
import 'package:quizz_app/app/modules/wrongSentence/view/wrong_Sentence_view.dart';

class ButtonWidget extends GetView<QuestionImageController> {
  const ButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics:const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HomeButtonWidget(
                ontap: () {
                  controller.navigateToQuestions();
                },
                text: Strings.random,
                child: Icon(
                  Icons.access_alarms,
                  size: 35.sp,
                ),
              ),
              HomeButtonWidget(
                ontap: () => Get.toNamed(TestKitView.routesname),
                text: Strings.testkill,
                child: Icon(
                  Icons.article_outlined,
                  size: 35.sp,
                ),
              ),
            ],
          ),
          SizedBox(width: 0.0, height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HomeButtonWidget(
                ontap: () => controller.navigateToQuestionsWrong(),
                text: Strings.sentence,
                child: Icon(
                  Icons.playlist_remove_rounded,
                  size: 35.sp,
                ),
              ),
              HomeButtonWidget(
                ontap: () => Get.toNamed(TipsView.routeName),
                text: Strings.tips,
                child: Icon(
                  Icons.auto_awesome_sharp,
                  size: 35.sp,
                ),
              ),
            ],
          ),
          SizedBox(width: 0.0, height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HomeButtonWidget(
                ontap: () => Get.toNamed(ReviewView.routeName),
                text: Strings.rank,
                child: Icon(
                  Icons.bar_chart_outlined,
                  size: 35.sp,
                ),
              ),
              HomeButtonWidget(
                ontap: () => Get.toNamed('allquestions'),
                text: Strings.allquestions,
                child: Icon(
                  Icons.auto_stories_outlined,
                  size: 35.sp,
                ),
              ),
            ],
          ),
          SizedBox(width: 0.0, height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HomeButtonWidget(
                  ontap: () => Get.toNamed(ChatGptView.routeName),
                  text: Strings.chatgpt,
                  child: Image.asset(
                    "assets/images/logochatgpt.png",
                    height: 50.h,
                    width: 50.w,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
