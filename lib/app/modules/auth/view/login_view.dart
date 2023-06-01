import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quizz_app/app/common/values/app_image.dart';
import 'package:quizz_app/app/common/values/style/string.dart';
import 'package:quizz_app/app/modules/auth/controller/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({Key? key}) : super(key: key);
  static const String routeName = "/login";
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
              width: 500.w * 0.3,
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppImages.login,
                  width: 200.w,
                  height: 200.h,
                ),
                SizedBox(width: 0.0, height: 20.h),
                InkWell(
                  onTap: () {
                    controller.singInWithGoogle();
                  },
                  child: Container(
                    width: 230.w,
                    padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 9, bottom: 9)
                        .r,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.0,
                        color: const Color.fromARGB(255, 233, 88, 88),
                      ),
                      borderRadius:
                          BorderRadius.all(const Radius.circular(7.0).r),
                      color: const Color.fromARGB(255, 245, 245, 245),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/google.png",
                          width: 25.w,
                          height: 25.h,
                        ),
                        SizedBox(width: 8.w, height: 0.0),
                        const Text(Strings.logingoogle),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
