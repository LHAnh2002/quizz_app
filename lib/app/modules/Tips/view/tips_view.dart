import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizz_app/app/common/values/app_color.dart';
import 'package:quizz_app/app/common/values/style/app_text_style.dart';
import 'package:quizz_app/app/common/values/style/string.dart';
import 'package:quizz_app/app/modules/Tips/controller/tips_controller.dart';

class TipsView extends GetView<TipsController> {
  const TipsView({Key? key}) : super(key: key);
  static const String routeName = '/tipsview';

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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 10,
                    bottom: 20,
                  ).r,
                  child: SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        InkWell(
                          onTap: () => Get.back(),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 25.sp,
                          ),
                        ),
                        SizedBox(width: 25.w, height: 0.0),
                        Text(
                          Strings.tips,
                          style: AppTextStyle.semiBoldMediumStyle.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(
                  () => Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10).r,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1.0,
                                  color: const Color.fromARGB(255, 233, 88, 88),
                                ),
                                borderRadius: BorderRadius.all(
                                    const Radius.circular(7.0).r),
                                color:
                                    const Color.fromARGB(255, 245, 245, 245)),
                            width: double.infinity,
                            height: 40.h,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: TabBar(
                                controller: controller.tabController,
                                isScrollable: true,
                                tabs: controller.questionsList.map((question) {
                                  return Tab(
                                    text: question.title,
                                  );
                                }).toList(),
                                labelColor: AppColors.black,
                                labelStyle:
                                    AppTextStyle.semiBoldMediumStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20).r,
                              child: GetBuilder<TipsController>(
                                builder: (_) {
                                  return TabBarView(
                                    controller: controller.tabController,
                                    children: controller.questionsList.map(
                                      (question) {
                                        return SingleChildScrollView(
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount:
                                                question.keyboard?.length ?? 0,
                                            itemBuilder: (context, index) {
                                              final keyboard =
                                                  question.keyboard![index];
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Divider(
                                                    color: Color.fromARGB(
                                                        255, 233, 88, 88),
                                                    thickness: 1.5,
                                                  ),
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: Text(
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      keyboard.title,
                                                      style: AppTextStyle
                                                          .semiBoldMediumStyle
                                                          .copyWith(
                                                              color: AppColors
                                                                  .black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                  ),
                                                  const Divider(
                                                    color: Color.fromARGB(
                                                        255, 233, 88, 88),
                                                    thickness: 1.5,
                                                  ),
                                                  SizedBox(height: 8.h),
                                                  ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemCount: keyboard
                                                        .shortcuts!.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final shortcut = keyboard
                                                          .shortcuts![index];
                                                      return SizedBox(
                                                        width: double.infinity,
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 150.w,
                                                                  child: Text(
                                                                    maxLines: 3,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    shortcut
                                                                        .keys,
                                                                    style: AppTextStyle
                                                                        .semiBoldMediumStyle
                                                                        .copyWith(
                                                                      color: AppColors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 20.0,
                                                                  child:
                                                                      VerticalDivider(
                                                                    width: 8,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            233,
                                                                            88,
                                                                            88),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    shortcut
                                                                        .comment,
                                                                    style: AppTextStyle
                                                                        .semiBoldMediumStyle
                                                                        .copyWith(
                                                                      color: AppColors
                                                                          .black,
                                                                      fontSize:
                                                                          15.sp,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const Divider(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      233,
                                                                      88,
                                                                      88),
                                                              thickness: 0.7,
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ).toList(),
                                  );
                                },
                              )),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
