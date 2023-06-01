import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quizz_app/app/common/controller/firebase_ref/loading_status.dart';
import 'package:quizz_app/app/common/values/app_color.dart';
import 'package:quizz_app/app/common/values/style/app_text_style.dart';
import 'package:quizz_app/app/modules/Testkit/models/test_kill_model.dart';
import 'package:quizz_app/app/modules/Testkit/view/test_kit_view.dart';
import 'package:quizz_app/app/modules/Testkit/widgets/test_kill_result_screen.dart';
import 'package:quizz_app/app/modules/home/controller/quesition_image_controller.dart';
import 'package:quizz_app/app/modules/home/view/home_view.dart';

class TestKillQuestionController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;
  final questionsList = <TestKillQuestions>[].obs;
  var currentIndex = 0.obs;
  bool isFirstIteration = true;
  bool get isFirstQuestion => currentIndex.value > 0;
  bool get isLastQuestion => currentIndex.value >= questionsList.length - 1;
  Rxn<TestKillQuestions> currentQuestion = Rxn<TestKillQuestions>();
  final Random random = Random();
  final box = GetStorage();

  //time
  Timer? _timer;
  int remainSeconds = 1;
  final time = '00.00'.obs;

  @override
  void onReady() {
    print('...onReady...');
    loadData("");
    super.onReady();
  }

  void nextQuestion() {
    if (currentIndex.value >= questionsList.length - 1) return;
    currentIndex.value++;
    currentQuestion.value = questionsList[currentIndex.value];
  }

  void previousQuestion() {
    if (currentIndex.value <= 0) return;
    currentIndex.value--;
    currentQuestion.value = questionsList[currentIndex.value];
  }

  Future<void> loadData(String id) async {
    loadingStatus.value = LoadingStatus.loading;
    try {
      final jsonString = box.read('topicsAllList');
      if (jsonString != null) {
        final jsonData = json.decode(jsonString);
        final allQuestions = (jsonData as List<dynamic>)
            .map((question) => TestKillQuestions.fromJson(question))
            .where((question) => question.id_title == id) // lọc theo id
            .toList();

        questionsList.assignAll(allQuestions);
        await Future.delayed(Duration.zero);
        if (allQuestions.isNotEmpty) {
          loadingStatus.value = LoadingStatus.completed;
          currentQuestion.value = questionsList[0];
          _startTimer(1800);
          if (kDebugMode) {
            print(questionsList[2].question);
          }
        } else {
          loadingStatus.value = LoadingStatus.error;
        }
      } else {
        loadingStatus.value = LoadingStatus.drum;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    print("dừng");
    // _timer!.cancel();
    // Get.delete<TestKillQuestionController>();
  }


  void selectedAnswer(String? id, String? answer) {
    saveTestResultss(id, answer);
    currentQuestion.value!.selectedAnswer = answer;

    update(['answers_list']);
  }

  String get completedTest {
    final answered = questionsList
        .where((element) => element.selectedAnswer != "")
        .toList()
        .length;
    return '$answered/${questionsList.length} đã trả lời';
  }

  void jumpToQuestion(int index, {bool isGoBack = true}) {
    currentIndex.value = index;
    currentQuestion.value = questionsList[index];
    if (isGoBack) {
      Get.back();
    }
  }

  _startTimer(int seconds) {
    const ducation = Duration(seconds: 1);
    remainSeconds = seconds;
    _timer = Timer.periodic(ducation, (Timer timer) {
      if (remainSeconds == 0) {
        timer.cancel();
        autuComplete();
      } else {
        int mimues = remainSeconds ~/ 60;
        int seconds = remainSeconds % 60;
        time.value = mimues.toString().padLeft(2, '0') +
            ':' +
            seconds.toString().padLeft(2, '0');
        remainSeconds--;
      }
    });
  }

  void autuComplete() {
    _timer!.cancel();
    Get.offNamed(TestKillResultScreen.rountName);
  }

  void complete() {
    final answered = questionsList
        .where((element) => element.selectedAnswer != "")
        .toList()
        .length;
    final unanswered =
        questionsList.where((element) => element.selectedAnswer == "").toList();
    // if (answered < questionsList.length) {
    //   Get.snackbar(
    //     "Thông báo",
    //     "Bạn còn ${unanswered.length} câu chưa trả lời",
    //     backgroundColor: AppColors.kButtonColor,
    //     titleText: Text(
    //       'Thông báo',
    //       style: AppTextStyle.semiBoldMediumStyle.copyWith(
    //         color: AppColors.white,
    //         fontSize: 20.sp,
    //         fontWeight: FontWeight.bold,
    //       ),
    //     ),
    //     messageText: Text(
    //       'Bạn còn ${unanswered.length} câu chưa trả lời',
    //       style: AppTextStyle.semiBoldMediumStyle.copyWith(
    //         color: AppColors.white,
    //         fontSize: 15.sp,
    //       ),
    //     ),
    //   );
    //   return;
    // }
    _timer!.cancel();
    Get.offAndToNamed(TestKillResultScreen.rountName);
  }

  void tryAgain() {
    Get.find<QuestionImageController>()
        .navigateToTestKillQuestions(tryAgain: true);
  }

  Future<void> saveTestResultss(String? id, String? answer) async {
    final jsonData = box.read('topicsAllList');
    if (jsonData != null) {
      final List<dynamic> decodedData = jsonDecode(jsonData);
      final updatedData = decodedData.map((question) {
        if (question['id'] == id) {
          return {
            ...question,
            'selected_answer': answer,
          };
        }
        return question;
      }).toList();

      box.write('topicsAllList', jsonEncode(updatedData));
    }
  }

  void gohome() {
    Get.offAllNamed(TestKitView.routesname);
  }

  void navigateToHome() {
    _timer!.cancel();
    Get.offAllNamed(HomeView.home);
  }
}
