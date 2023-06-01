import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizz_app/app/common/values/style/app_text_style.dart';
import 'package:quizz_app/app/common/values/style/string.dart';

class Dialogs {
  static final Dialogs _delete = Dialogs._internal();
  Dialogs._internal();

  factory Dialogs() {
    return _delete;
  }
  static Widget questionStartDialogue(
      {required VoidCallback ontapskip, required VoidCallback ontapconfirm}) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            Strings.deletetitle,
            style: AppTextStyle.semiBoldMediumStyle
                .copyWith(fontWeight: FontWeight.bold, fontSize: 20.sp),
          ),
          Text(
            Strings.deletecoment,
            textAlign: TextAlign.center,
            style: AppTextStyle.semiBoldMediumStyle.copyWith(fontSize: 15.sp),
          ),
        ],
      ),
      actions: [
        InkWell(
          onTap: ontapskip,
          child: Container(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 9, bottom: 9).r,
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1.0,
                  color: const Color.fromARGB(255, 233, 88, 88),
                ),
                borderRadius: BorderRadius.all(const Radius.circular(7.0).r),
                color: const Color.fromARGB(255, 245, 245, 245)),
            child: const Text(Strings.skip),
          ),
        ),
        InkWell(
          onTap: ontapconfirm,
          child: Container(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 9, bottom: 9).r,
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1.0,
                  color: const Color.fromARGB(255, 233, 88, 88),
                ),
                borderRadius: BorderRadius.all(const Radius.circular(7.0).r),
                color: const Color.fromARGB(255, 245, 245, 245)),
            child: const Text(Strings.confirm),
          ),
        )
      ],
    );
  }
}
