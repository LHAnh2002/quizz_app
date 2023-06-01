import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizz_app/app/modules/widgets/shimmer.dart';

class RandomTopicLoading extends StatelessWidget {
  const RandomTopicLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
              Container(
                alignment: Alignment.center,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 25, right: 25, top: 20).r,
                  child: Column(
                    children: [
                      customShimmer(height: 60.h, width: 330.w),
                      SizedBox(width: 0.0, height: 20.h),
                      customShimmer(height: 170.h, width: 330.w),
                      SizedBox(width: 0.0, height: 20.h),
                      customShimmer(height: 50.h, width: 330.w),
                      SizedBox(width: 0.0, height: 10.h),
                      customShimmer(height: 50.h, width: 330.w),
                      SizedBox(width: 0.0, height: 10.h),
                      customShimmer(height: 50.h, width: 330.w),
                      SizedBox(width: 0.0, height: 10.h),
                      customShimmer(height: 50.h, width: 330.w),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
