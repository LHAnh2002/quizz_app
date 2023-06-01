import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:quizz_app/app/modules/auth/controller/auth_controller.dart';
import 'package:quizz_app/app/modules/auth/widgets/AppLogger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/values/app_color.dart';
import '../../../common/values/style/app_text_style.dart';

class MyZoomDrawerController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();
  Rxn<User?> user = Rxn();
  RxString utf8Text = ''.obs;
  final text = ''.obs;

  void updateText(String newText) {
    text.value = newText;
  }

  @override
  void onReady() {
    user.value = Get.find<AuthController>().getUser();
    super.onReady();
  }

  void toogleDrawer() {
    zoomDrawerController.toggle?.call();
    update();
  }

  void singOut() {
    Get.find<AuthController>().signOut();
  }

  void singIn() {}
  void facebook() {
    _launch("https://www.facebook.com");
  }

  void email() {
    final Uri emailLaunchUri = Uri(
      scheme: 'LHAnh',
      path: 'leeanh02112002@gmail.com',
    );
    _launch(emailLaunchUri.toString());
  }

  Future<void> _launch(String url) async {
    if (!await launch(url)) {
      throw 'Không thể khởi chạy $url';
    }
  }

  void copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar(
      'Sao chép thành công',
      'Đoạn văn bản đã được sao chép',
      backgroundColor: AppColors.kButtonColor,
      titleText: Text(
        "Thông báo",
        style: AppTextStyle.semiBoldMediumStyle.copyWith(
          color: AppColors.white,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      messageText: Text(
        "Đoạn văn bản đã được sao chép",
        style: AppTextStyle.semiBoldMediumStyle.copyWith(
          color: AppColors.white,
          fontSize: 15.sp,
        ),
      ),
    );
  }
}
