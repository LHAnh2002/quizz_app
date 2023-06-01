import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quizz_app/app/common/controller/firebase_ref/loading_status.dart';
import 'package:quizz_app/app/common/models/question_pape_moder.dart';
import 'package:quizz_app/app/modules/home/view/home_view.dart';

class WrongController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;
  final questionsList = <Questions>[].obs;
  var currentIndex = 0.obs;
  bool isFirstIteration = true;
  bool get isFirstQuestion => currentIndex.value > 0;
  bool get isLastQuestion => currentIndex.value >= questionsList.length - 1;
  Rxn<Questions> currentQuestion = Rxn<Questions>();
  var isAnswerSelected = true.obs;
  final box = GetStorage();

  @override
  void onReady() {
    print('...onReady...');
    loadData();
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

  void goHome() {
    questionsList.clear();
    currentIndex.value = 0;
    Get.toNamed(HomeView.home);
  }

  Future<void> loadData() async {
    loadingStatus.value = LoadingStatus.loading;
    try {
      final jsonString = box.read('wrong_answers');
      if (jsonString != null) {
        final jsonData = json.decode(jsonString);
        final allQuestions = (jsonData as List<dynamic>)
            .map((question) => Questions.fromJson(question))
            .toList();

        questionsList.assignAll(allQuestions);
        await Future.delayed(Duration.zero);
        if (allQuestions.isNotEmpty) {
          loadingStatus.value = LoadingStatus.completed;
          currentQuestion.value = questionsList[0];
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

  void reset() {
    Get.back();
    questionsList.clear();
    currentIndex.value = 0;
  }

  String get completedTest {
    final answered = questionsList
        .where((element) => element.selectedAnswer != "")
        .toList()
        .length;
    return '$answered/${questionsList.length} đã trả lời';
  }

  void selectedAnswer(String? answer) {
    currentQuestion.value!.selectedAnswer = answer;
    update(['answers_list']);
  }

  void deleteAnswer() async {
    await box.remove('wrong_answers');
    Get.offAllNamed(HomeView.home);
  }

  void jumpToQuestion(int index, {bool isGoBack = true}) {
    currentIndex.value = index;
    currentQuestion.value = questionsList[index];
    if (isGoBack) {
      Get.back();
    }
  }
}
