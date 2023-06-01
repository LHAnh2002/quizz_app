import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quizz_app/app/common/controller/firebase_ref/loading_status.dart';
import 'package:quizz_app/app/common/models/question_pape_moder.dart';
import 'package:quizz_app/app/common/values/app_color.dart';
import 'package:quizz_app/app/common/values/style/app_text_style.dart';
import 'package:quizz_app/app/modules/home/controller/quesition_image_controller.dart';
import 'package:quizz_app/app/modules/home/view/home_view.dart';
import 'package:quizz_app/app/modules/widgets/result_screen.dart';

class RandomTopicController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;
  final questionsList = <Questions>[].obs;
  var currentIndex = 0.obs;
  bool isFirstIteration = true;
  bool get isFirstQuestion => currentIndex.value > 0;
  bool get isLastQuestion => currentIndex.value >= questionsList.length - 1;
  Rxn<Questions> currentQuestion = Rxn<Questions>();
  final Random random = Random();
  final box = GetStorage();

  //time
  Timer? _timer;
  int remainSeconds = 1;
  final time = '00.00'.obs;

  @override
  void onReady() {
    print('...onReady...');
    loadData();
    super.onReady();
  }

  List<T> getRandomItems<T>(List<T> list) {
    if (list.length <= 6) {
      return list;
    }
    final List<T> result = [];
    while (result.length < 6) {
      final int randomIndex = random.nextInt(list.length);
      final T item = list[randomIndex];
      if (!result.contains(item)) {
        result.add(item);
      }
    }
    return result;
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

  Future<void> loadData() async {
    loadingStatus.value = LoadingStatus.loading;

    try {
      final jsonString = box.read('questionsList');
      if (jsonString != null) {
        final jsonData = json.decode(jsonString);
        final allQuestions = (jsonData as List<dynamic>)
            .map((question) => Questions.fromJson(question))
            .toList();
        final filteredQuestions = <Questions>[];
        for (var title in ['1', '2', '3', '4', '5']) {
          final titleQuestions = getRandomItems(allQuestions).toSet().toList();
          filteredQuestions.addAll(titleQuestions);
        }
        questionsList.assignAll(filteredQuestions);
        await Future.delayed(Duration.zero);
        if (filteredQuestions.isNotEmpty) {
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

  Future<void> loadDatas() async {
    loadingStatus.value = LoadingStatus.loading;

    try {
      final jsonString = box.read('questionsList');
if (jsonString != null) {
  final jsonData = json.decode(jsonString);
  final allQuestions = (jsonData as List<dynamic>)
      .map((question) => Questions.fromJson(question))
      .toList();
  final filteredQuestions = <Questions>[];

  for (var id = 1; id <= 5; id++) {
    final idQuestions = allQuestions.where((question) => question.id == id).toList();

    final difficultQuestions = idQuestions.where((question) => question.difficulty == 0).toList();
    final easyQuestions = idQuestions.where((question) => question.difficulty == 1).toList();

    final numDifficultQuestions = 1 + random.nextInt(2); // Số lượng câu hỏi khó từ 1 đến 2
    final numEasyQuestions = 6 - numDifficultQuestions; // Số lượng câu hỏi dễ còn lại

    final difficultRandomQuestions = getRandomItems(difficultQuestions).take(numDifficultQuestions).toList();
    final easyRandomQuestions = getRandomItems(easyQuestions).take(numEasyQuestions).toList();

    filteredQuestions.addAll(difficultRandomQuestions);
    filteredQuestions.addAll(easyRandomQuestions);
  }

  questionsList.assignAll(filteredQuestions);
  await Future.delayed(Duration.zero);
  if (filteredQuestions.isNotEmpty) {
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

  void selectedAnswer(String? answer) {
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
    Get.offAndToNamed(ResultScreen.rountName);
  }

  void complete() {
    final answered = questionsList
        .where((element) => element.selectedAnswer != "")
        .toList()
        .length;
    final unanswered = questionsList
        .where((element) => element.selectedAnswer == "")
        .toList();
    // if (answered < questionsList.length) {
    //   Get.snackbar(
    //     "Thông báo",
    //     "Bạn còn ${unanswered.length} câu chưa trả lời",
    //     backgroundColor: AppColors.kButtonColor,
    //     titleText: Text(
    //       'Thông báo',
    //       style: AppTextStyle.semiBoldMediumStyle.copyWith(
    //           color: AppColors.white,
    //           fontSize: 20.sp,
    //           fontWeight: FontWeight.bold),
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
    Get.offAndToNamed(ResultScreen.rountName);
  }

  void tryAgain() {
    Get.find<QuestionImageController>().navigateToQuestions(tryAgain: true);
  }

  Future<void> saveTestResults() async {
    final existingData = box.read('wrong_answers');
    List<Questions> wrongAnswers = [];
    if (existingData != null) {
      final jsonData = json.decode(existingData);
      wrongAnswers.addAll((jsonData as List<dynamic>)
          .map((question) => Questions.fromJson(question))
          .toList());
    }

    for (var question in questionsList) {
      if (question.selectedAnswer != question.correctAnswer) {
        wrongAnswers.add(question);
      }
    }
    final jsonData = jsonEncode(wrongAnswers);
    await box.write('wrong_answers', jsonData);
    navigateToHome();
  }

  void navigateToHome() {
    _timer!.cancel();
    Get.offAllNamed(HomeView.home);
  }
}
