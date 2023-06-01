import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quizz_app/app/common/controller/firebase_ref/loading_status.dart';
import 'package:quizz_app/app/modules/Testkit/models/test_kill_model.dart';
import 'package:quizz_app/app/modules/Testkit/view/test_kit_view.dart';
import 'package:quizz_app/app/modules/Testkit/widgets/dialongs_delete.dart';
import 'package:quizz_app/app/modules/home/view/home_view.dart';

class TestKillController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;
  final questionsList = <TestKillQuestionPaperModel>[].obs;
  Rxn<TestKillQuestionPaperModel> currentQuestion =
      Rxn<TestKillQuestionPaperModel>();
  final box = GetStorage();
  @override
  void onReady() {
    // TODO: implement onReady
    loadData();
    super.onReady();
  }

  Future<void> loadData() async {
    loadingStatus.value = LoadingStatus.loading;

    try {
      final jsonString = box.read('topicsList');
      if (jsonString != null) {
        final jsonData = json.decode(jsonString);
        final allQuestions = (jsonData as List<dynamic>)
            .map((question) => TestKillQuestionPaperModel.fromJson(question))
            .toList();
        allQuestions
            .sort((q1, q2) => int.parse(q1.stt).compareTo(int.parse(q2.stt)));
        questionsList.assignAll(allQuestions);

        await Future.delayed(Duration.zero);
        if (allQuestions.isNotEmpty) {
          loadingStatus.value = LoadingStatus.completed;
          currentQuestion.value = questionsList[0];

          if (kDebugMode) {
            print(questionsList[2]);
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

  void showDialogDelete() {
    Get.dialog(
      Dialogs.questionStartDialogue(
        ontapconfirm: () {
          resetSelectedAnswers();
          resettopicsList();
          loadData();
          Get.offAndToNamed(TestKitView.routesname);
        },
        ontapskip: () {
          Get.back();
        },
      ),
      barrierDismissible: false,
    );
  }

  Future<void> resettopicsList() async {
    final jsonData = box.read('topicsList');
    if (jsonData != null) {
      final List<dynamic> decodedData = jsonDecode(jsonData);
      final updatedData = decodedData.map((question) {
        return {
          ...question,
          'correct': "",
          'wrong': "",
        };
      }).toList();

      box.write('topicsList', jsonEncode(updatedData));
    }
  }

  Future<void> resetSelectedAnswers() async {
    final jsonData = box.read('topicsAllList');
    if (jsonData != null) {
      final List<dynamic> decodedData = jsonDecode(jsonData);
      final updatedData = decodedData.map((question) {
        return {
          ...question,
          'selected_answer': "",
        };
      }).toList();

      box.write('topicsAllList', jsonEncode(updatedData));
    }
  }
}
