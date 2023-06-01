import 'dart:convert';

import 'package:quizz_app/app/modules/Testkit/controller/test_kill_question_controller.dart';

extension TestKillQuestionControllerExtension on TestKillQuestionController {
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

  Future<void> saveTestResultsTime(String id) async {
    print('$correctQuestionCount');
    print('${questionsList.length - correctQuestionCount}');
    final jsonData = box.read('topicsList');
    if (jsonData != null) {
      final List<dynamic> decodedData = jsonDecode(jsonData);
      final updatedData = decodedData.map((question) {
        if (question['id'] == id) {
          return {
            ...question,
            'correct': "$correctQuestionCount",
            'wrong': "${questionsList.length - correctQuestionCount}",
          };
        }
        return question;
      }).toList();

      box.write('topicsList', jsonEncode(updatedData));
    }
    navigateToHome();
    questionsList.clear();
  }
}
