import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizz_app/app/common/values/style/string.dart';
import 'package:quizz_app/app/modules/widgets/app_cicle_button.dart';

class AppIntroductionScreen extends StatelessWidget {
  const AppIntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.2).r,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                size: 65.sp,
              ),
              SizedBox(width: 0.0, height: 40.h),
              Text(
                Strings.introdoction,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Quicksand",
                ),
              ),
              SizedBox(width: 0.0, height: 40.h),
              AppCicleButton(
                ontap: () => Get.offAllNamed('/home'),
                child: Icon(
                  Icons.arrow_forward,
                  size: 35.sp,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
