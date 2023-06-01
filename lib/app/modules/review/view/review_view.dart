import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizz_app/app/common/values/app_color.dart';
import 'package:quizz_app/app/common/values/style/app_text_style.dart';
import 'package:quizz_app/app/common/values/style/string.dart';
import 'package:quizz_app/app/modules/review/controller/rank_controller.dart';

class ReviewView extends GetView<RankController> {
  const ReviewView({Key? key}) : super(key: key);
  static const String routeName = '/rankview';
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
                          Strings.rank,
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
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15, left: 15).r,
                        child: Container(
                          padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 5, bottom: 5)
                              .r,
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.0,
                                color: const Color.fromARGB(255, 233, 88, 88),
                              ),
                              borderRadius: BorderRadius.all(
                                  const Radius.circular(7.0).r),
                              color: const Color.fromARGB(255, 245, 245, 245)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Rank',
                                style:
                                    AppTextStyle.semiBoldMediumStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.sp,
                                ),
                              ),
                              Text(
                                'Tên',
                                style:
                                    AppTextStyle.semiBoldMediumStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.sp,
                                ),
                              ),
                              Text(
                                'Điểm',
                                style:
                                    AppTextStyle.semiBoldMediumStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Obx(
                        () => Expanded(
                          child: ListView.builder(
                              physics: const ScrollPhysics(),
                              primary: false,
                              itemCount: controller.userList.length,
                              itemBuilder: (context, index) {
                                final user = controller.userList[index];
                                final rankNumber = index + 1;
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15, right: 15)
                                          .r,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                                left: 10, right: 10)
                                            .r,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              child: Text(
                                                rankNumber.toString(),
                                                style: AppTextStyle
                                                    .semiBoldMediumStyle
                                                    .copyWith(
                                                  color: AppColors.black,
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              flex: 7,
                                              child: Text(
                                                user.name,
                                                style: AppTextStyle
                                                    .semiBoldMediumStyle
                                                    .copyWith(
                                                  color: AppColors.black,
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              flex: 1,
                                              child: GetBuilder<RankController>(
                                                builder: (_) {
                                                  return ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        user.rank!.length,
                                                    itemBuilder:
                                                        (context, rankIndex) {
                                                      final rank =
                                                          user.rank![rankIndex];
                                                      return Row(
                                                        children: <Widget>[
                                                          Text(
                                                            rank.points
                                                                .toString(),
                                                            style: AppTextStyle
                                                                .semiBoldMediumStyle
                                                                .copyWith(
                                                              color: AppColors
                                                                  .black,
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        color: Color.fromARGB(255, 233, 88, 88),
                                        thickness: 1.5,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
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
