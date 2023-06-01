import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quizz_app/app/common/controller/firebase_ref/loading_status.dart';
import 'package:quizz_app/app/modules/Testkit/widgets/dialongs_delete.dart';
import 'package:quizz_app/app/modules/allQuestions/models/question_all_models.dart';
import 'package:quizz_app/app/modules/home/view/home_view.dart';

class AllQuestionWordController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;
  final questionsList = <AllQuestions>[].obs;
  var currentIndex = 0.obs;
  bool isFirstIteration = true;
  bool get isFirstQuestion => currentIndex.value > 0;
  bool get isLastQuestion => currentIndex.value >= questionsList.length - 1;
  Rxn<AllQuestions> currentQuestion = Rxn<AllQuestions>();
  var isAnswerSelected = true.obs;
  RxBool isCorrectAnswerVisible = false.obs;
  final box = GetStorage();
  @override
  void onReady() {
    print('...onReady...');
    loadData("myTitle");
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

  Future<void> loadData(String idTitle) async {
    loadingStatus.value = LoadingStatus.loading;

    try {
      final jsonString = box.read('AllquestionsList');
      if (jsonString != null) {
        final jsonData = json.decode(jsonString);
        final allQuestions = (jsonData as List<dynamic>)
            .map((question) => AllQuestions.fromJson(question))
            .toList();
        final filteredQuestions = allQuestions
            .where((question) => question.id_title == idTitle)
            .toList();

        questionsList.assignAll(filteredQuestions);
        await Future.delayed(Duration.zero);
        if (filteredQuestions.isNotEmpty) {
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
        loadingStatus.value = LoadingStatus.error;
      }
    }
  }

  void reset() {
    Get.back();
    questionsList.clear();
    currentIndex.value = 0;
  }

  void selectedAnswer(String? answer, String id) {
    currentQuestion.value!.selectedAnswer = answer!;
    saveTestResults(id, answer);
    // showCorrectAnswer();
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

  Future<void> saveTestResults(String? id, String? answer) async {
    final jsonData = box.read('AllquestionsList');
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

      box.write('AllquestionsList', jsonEncode(updatedData));
    }
  }

  void showDialogDelete() {
    Get.dialog(
      Dialogs.questionStartDialogue(
        ontapconfirm: () {
          resetSelectedAnswers();
          // resettopicsList();
          // loadData();
          Get.toNamed(HomeView.home);
        },
        ontapskip: () {
          Get.back();
        },
      ),
      barrierDismissible: false,
    );
  }

  // Future<void> resettopicsList() async {
  //   final jsonData = box.read('topicsList');
  //   if (jsonData != null) {
  //     final List<dynamic> decodedData = jsonDecode(jsonData);
  //     final updatedData = decodedData.map((question) {
  //       return {
  //         ...question,
  //         'correct': "",
  //         'wrong': "",
  //       };
  //     }).toList();

  //     box.write('topicsList', jsonEncode(updatedData));
  //   }
  // }

  Future<void> resetSelectedAnswers() async {
    final jsonData = box.read('AllquestionsList');
    if (jsonData != null) {
      final List<dynamic> decodedData = jsonDecode(jsonData);
      final updatedData = decodedData.map((question) {
        return {
          ...question,
          'selected_answer': "",
        };
      }).toList();

      box.write('AllquestionsList', jsonEncode(updatedData));
    }
  }
}
