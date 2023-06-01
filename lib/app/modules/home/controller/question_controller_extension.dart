import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:quizz_app/app/common/controller/firebase_ref/references.dart';
import 'package:quizz_app/app/modules/auth/controller/auth_controller.dart';
import 'package:quizz_app/app/modules/randomTopic/controller/randomTopic_controller.dart';

extension QuestionControllerExtension on RandomTopicController {
  int get correctQuestionCount => questionsList
      .where((element) => element.selectedAnswer == element.correctAnswer)
      .toList()
      .length;

  String get correctAnsweredQuestion {
    return '$correctQuestionCount/${questionsList.length} câu đúng';
  }

  String get points {
    var points = (correctQuestionCount / questionsList.length) * 10;
    return points.toStringAsFixed(2);
  }

  String get points_time {
    var points = (correctQuestionCount / questionsList.length) *
        10 *
        (1800 - remainSeconds) /
        1800 *
        10;
    return points.toStringAsFixed(2);
  }

  Future<void> saveTestResultsTime() async {
    var batch = fireStore.batch();
    User? _user = Get.find<AuthController>().getUser();
    if (_user == null) return;
    batch.set(userRF.doc(_user.email).collection('rank').doc(), {
      "times": Timestamp.now(),
      "points": num.parse(points_time),
      "correct_answer": '$correctQuestionCount/${questionsList.length}',
      "time": 1800 - remainSeconds,
    });
    await batch.commit();
    questionsList.clear();
  }
}
