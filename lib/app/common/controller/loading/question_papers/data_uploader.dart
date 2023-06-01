import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizz_app/app/common/controller/firebase_ref/loading_status.dart';
import 'package:quizz_app/app/common/controller/firebase_ref/references.dart';
import 'package:quizz_app/app/common/models/question_pape_moder.dart';

class DataUploader extends GetxController {
  @override
  void onReady() {
    upLoadData();
    super.onReady();
  }

  final loadingStatus = LoadingStatus.loading.obs; //loadingStatus in obs
  Future<void> upLoadData() async {
    loadingStatus.value = LoadingStatus.loading;
    final fireStore = FirebaseFirestore.instance;
    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString("AssetManifest.json");
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    //tải tệp json và đường dẫn in
    final papersInAssets = manifestMap.keys
        .where((path) =>
            path.startsWith("assets/papers") && path.contains(".json"))
        .toList();
    List<QuestionPaperModel> questionPaperModel = [];
    for (var paper in papersInAssets) {
      String stringPaperContent = await rootBundle.loadString(paper);
      questionPaperModel
          .add(QuestionPaperModel.fromJson(json.decode(stringPaperContent)));
    }
    // print('Items number ${questionPaperModel[0].description}');
    var batch = fireStore.batch();

    for (var paper in questionPaperModel) {
      batch.set(questionPaperRF.doc(paper.id), {
        "title": paper.title,
        "image_url": paper.imageUrl,
        "description": paper.description,
        "time_seconds": paper.timeSeconds,
        "questions_count": paper.questions == null ? 0 : paper.questions!.length
      });
      for (var questions in paper.questions!) {
        final questionPath =
            questionRF(paperId: paper.id, questionId: questions.id);
        batch.set(questionPath, {
          "question": questions.question,
          "image_url": questions.imageUrl,
          "correct_answer": questions.correctAnswer
        });
        for (var answer in questions.answers) {
          batch.set(questionPath.collection("answers").doc(answer.identifier),
              {"identifier": answer.identifier, "answer": answer.answer});
        }
      }
    }

    await batch.commit();
    loadingStatus.value = LoadingStatus.completed;
  }
}
