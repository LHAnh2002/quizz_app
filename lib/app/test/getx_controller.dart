import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quizz_app/app/common/controller/firebase_ref/references.dart';
import 'package:quizz_app/app/common/models/question_pape_moder.dart';
import 'package:quizz_app/app/modules/Testkit/models/test_kill_model.dart';
import 'package:quizz_app/app/modules/Tips/models/tips_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/values/app_color.dart';
import '../common/values/style/app_text_style.dart';

class GetxControllerCache extends GetxController {
  final box = GetStorage();
  final questionsList = <Questions>[].obs;
  final testKillQuestionList = <TestKillQuestions>[].obs;
  final testKillQuestionPaperList = <TestKillQuestionPaperModel>[].obs;
  final tipsList = <TipsModels>[].obs;
  late SharedPreferences _prefs;

  @override
  void onReady() async {
    print('...onReady...');
    bool isFirstTime = await _isFirstTime();
    // setOfTopicssaveData();
    // tipssaveData();
    if (isFirstTime) {
      print("bắt đầu saveData");
      await saveData();
      print("bắt đầu setOfTopicssaveData");
      await setOfTopicssaveData();
      print("bắt đầu testKillsaveData");
      await testKillsaveData();
      print("bắt đầu tipssaveData");
      await tipssaveData();
      await _setFirstTime();
    }
    super.onReady();
  }

  @override
  void onInit() async {
    _prefs = await SharedPreferences.getInstance();
    super.onInit();
  }

  Future<bool> _isFirstTime() async {
    return _prefs.getBool('first_time') ?? true;
  }

  Future<void> _setFirstTime() async {
    await _prefs.setBool('first_time', false);
  }

  Future<void> saveData() async {
    try {
      Get.snackbar(
        "Thông báo",
        "Bắt đầu tải update",
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
          "Bắt đầu tải update",
          style: AppTextStyle.semiBoldMediumStyle.copyWith(
            color: AppColors.white,
            fontSize: 15.sp,
          ),
        ),
      );
      final querySnapshot = await questionsRF.get();
      final questions = querySnapshot.docs
          .map((snapshot) => Questions.formSnapsort(snapshot))
          .toList();
      questionsList.addAll(questions);
      for (var question in questionsList) {
        final answerQuerySnapshot =
            await questionsRF.doc(question.id).collection("answers").get();
        final answers = answerQuerySnapshot.docs
            .map((snapshot) => Answers.fromSnapshot(snapshot))
            .toList();
        question.answers.assignAll(answers);
      }
      print("Hoàn thành saveData");
      final jsonData = jsonEncode(questionsList);
      await box.write('questionsList', jsonData);
      await box.write('AllquestionsList', jsonData);
      Get.snackbar(
        "Tải xuống",
        "Thành công 1/4",
        backgroundColor: AppColors.kButtonColor,
        titleText: Text(
          "Tải xuống",
          style: AppTextStyle.semiBoldMediumStyle.copyWith(
            color: AppColors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        messageText: Text(
          "Thành công 1/4",
          style: AppTextStyle.semiBoldMediumStyle.copyWith(
            color: AppColors.white,
            fontSize: 15.sp,
          ),
        ),
      );
      // final bytes = utf8.encode(jsonData);

      // await File('assets/json/questionsList.json').writeAsBytes(bytes);
    } catch (e) {
      if (kDebugMode) {
        print("lỗi: " + e.toString());
      }
    }
  }

  Future<void> testKillsaveData() async {
    try {
      final querySnapshot = await topicsRF.get();
      final questions = querySnapshot.docs
          .map((snapshot) => TestKillQuestions.formSnapsort(snapshot))
          .toList();
      testKillQuestionList.addAll(questions);
      for (var question in testKillQuestionList) {
        final answerQuerySnapshot =
            await topicsRF.doc(question.id).collection("answers").get();
        final answers = answerQuerySnapshot.docs
            .map((snapshot) => TestKillAnswers.fromSnapshot(snapshot))
            .toList();
        question.answers.assignAll(answers);
      }
      print("Hoàn thành testKillsaveData");
      final jsonData = jsonEncode(testKillQuestionList);
      await box.write('topicsAllList', jsonData);
      Get.snackbar(
        "Tải xuống",
        "Thành công 3/4",
        backgroundColor: AppColors.kButtonColor,
        titleText: Text(
          "Tải xuống",
          style: AppTextStyle.semiBoldMediumStyle.copyWith(
            color: AppColors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        messageText: Text(
          "Thành công 3/4",
          style: AppTextStyle.semiBoldMediumStyle.copyWith(
            color: AppColors.white,
            fontSize: 15.sp,
          ),
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print("lỗi: " + e.toString());
      }
    }
  }

  Future<void> setOfTopicssaveData() async {
    try {
      final querySnapshot = await setOfTopicsRF.get();
      final questions = querySnapshot.docs
          .map((snapshot) => TestKillQuestionPaperModel.formSnapsort(snapshot))
          .toList();
      testKillQuestionPaperList.addAll(questions);

      print("Hoàn thành setOfTopicssaveData");
      final jsonData = jsonEncode(testKillQuestionPaperList);
      await box.write('topicsList', jsonData);
      Get.snackbar(
        "Tải xuống",
        "Thành công 2/4",
        backgroundColor: AppColors.kButtonColor,
        titleText: Text(
          "Tải xuống",
          style: AppTextStyle.semiBoldMediumStyle.copyWith(
            color: AppColors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        messageText: Text(
          "Thành công 2/4",
          style: AppTextStyle.semiBoldMediumStyle.copyWith(
            color: AppColors.white,
            fontSize: 15.sp,
          ),
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print("lỗi: " + e.toString());
      }
    }
  }

  Future<void> tipssaveData() async {
    try {
      final querySnapshot = await tipRF.get();
      final questions = querySnapshot.docs
          .map((snapshot) => TipsModels.fromSnapshot(snapshot))
          .toList();
      tipsList.assignAll(questions);
      for (var keyboard in tipsList) {
        final answerQuerySnapshot =
            await tipRF.doc(keyboard.id).collection("keyboard").get();
        final answers = answerQuerySnapshot.docs
            .map((snapshot) => Keyboard.fromSnapshot(snapshot))
            .toList();
        keyboard.keyboard?.assignAll(answers);
        for (var shortcut in keyboard.keyboard ?? []) {
          final shortcutQuerySnapshot = await tipRF
              .doc(keyboard.id)
              .collection("keyboard")
              .doc(shortcut.id)
              .collection("shortcuts")
              .get();
          final shortcuts = shortcutQuerySnapshot.docs
              .map((snapshot) => Shortcutss.fromSnapshot(snapshot))
              .toList();
          shortcut.shortcuts?.addAll(shortcuts);
        }
      }
      print("Hoàn thành tipssaveData");
      final jsonData = jsonEncode(tipsList);
      await box.write('tipsList', jsonData);
      Get.snackbar(
        "Tải xuống",
        "Thành công 4/4",
        backgroundColor: AppColors.kButtonColor,
        titleText: Text(
          "Tải xuống",
          style: AppTextStyle.semiBoldMediumStyle.copyWith(
            color: AppColors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        messageText: Text(
          "Thành công 4/4",
          style: AppTextStyle.semiBoldMediumStyle.copyWith(
            color: AppColors.white,
            fontSize: 15.sp,
          ),
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print("lỗi: " + e.toString());
      }
    }
  }
}
