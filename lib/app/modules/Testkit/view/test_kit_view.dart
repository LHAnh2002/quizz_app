import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizz_app/app/common/values/app_color.dart';
import 'package:quizz_app/app/common/values/style/app_text_style.dart';
import 'package:quizz_app/app/common/values/style/string.dart';
import 'package:quizz_app/app/modules/Testkit/controller/test_kill_controller.dart';
import 'package:quizz_app/app/modules/Testkit/controller/test_kill_question_controller.dart';
import 'package:quizz_app/app/modules/Testkit/view/test_kill_question.dart';
import 'package:quizz_app/app/modules/Testkit/widgets/done/answer_check_widget.dart';
import 'package:quizz_app/app/modules/home/view/home_view.dart';

class TestKitView extends GetView<TestKillController> {
  const TestKitView({Key? key}) : super(key: key);
  static const String routesname = '/testkillview';
  @override
  Widget build(BuildContext context) {
    TestKillQuestionController testKillQuestionController = Get.find();
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        InkWell(
                          onTap: () => Get.offAllNamed(HomeView.home),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 25.sp,
                          ),
                        ),
                        Text(
                          Strings.testkill,
                          style: AppTextStyle.semiBoldMediumStyle.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.sp,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.showDialogDelete();
                          },
                          child: Icon(
                            Icons.delete_outline_outlined,
                            size: 35.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 0.0, height: 25.h),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150,
                        childAspectRatio: 1,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: controller.questionsList.value.length,

                      // ignore: prefer_const_literals_to_create_immutables
                      itemBuilder: (BuildContext context, int index) {
                        final wrong =
                            controller.questionsList.value[index].wrong;
                        return Obx(() {
                          if (wrong != "") {
                            return InkWell(
                              onTap: () {
                                final id =
                                    controller.questionsList.value[index].id;
                                testKillQuestionController.loadData(id);
                                Get.toNamed(AnswerCheckWidget.routeName);
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    height: 150.h,
                                    width: 175.w,
                                    padding: const EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            top: 9,
                                            bottom: 9)
                                        .r,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1.0,
                                          color: const Color.fromARGB(
                                              255, 233, 88, 88),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            const Radius.circular(7.0).r),
                                        color: const Color.fromARGB(
                                            255, 245, 245, 245)),
                                  ),
                                  Positioned.fill(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          controller
                                              .questionsList.value[index].title,
                                          // "xon",
                                          style: AppTextStyle
                                              .semiBoldMediumStyle
                                              .copyWith(
                                                  fontSize: 25.sp,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 0.0, height: 7.h),
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                        "${controller.questionsList.value[index].correct}",
                                                        style: AppTextStyle
                                                            .semiBoldMediumStyle
                                                            .copyWith(
                                                          color: AppColors
                                                              .kGreenText,
                                                        )),
                                                    Icon(
                                                      Icons.done,
                                                      size: 23.sp,
                                                      color:
                                                          AppColors.kGreenText,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                        "${controller.questionsList.value[index].wrong}",
                                                        style: AppTextStyle
                                                            .semiBoldMediumStyle
                                                            .copyWith(
                                                          color: Colors.red,
                                                        )),
                                                    Icon(
                                                      Icons.dangerous_outlined,
                                                      size: 23.sp,
                                                      color: Colors.red,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          } else {
                            return InkWell(
                              onTap: () {
                                final id =
                                    controller.questionsList.value[index].id;
                                testKillQuestionController.loadData(id);
                                Get.toNamed(TestKillQuestion.routesname);
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    height: 150.h,
                                    width: 175.w,
                                    padding: const EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            top: 9,
                                            bottom: 9)
                                        .r,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1.0,
                                          color: const Color.fromARGB(
                                              255, 233, 88, 88),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            const Radius.circular(7.0).r),
                                        color: const Color.fromARGB(
                                            255, 245, 245, 245)),
                                  ),
                                  Positioned.fill(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          controller
                                              .questionsList.value[index].title,
                                          // "xon",
                                          style: AppTextStyle
                                              .semiBoldMediumStyle
                                              .copyWith(
                                                  fontSize: 25.sp,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
