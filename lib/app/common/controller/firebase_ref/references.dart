import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:quizz_app/app/modules/auth/controller/auth_controller.dart';

final fireStore = FirebaseFirestore.instance;
Reference get firebaseStorage => FirebaseStorage.instance.ref();
User? _user = Get.find<AuthController>().getUser();

final questionsRF = fireStore.collection('questions');
final topicsRF = fireStore.collection('Topics');
final tipRF = fireStore.collection('tips');
final setOfTopicsRF = fireStore.collection('setOfTopics');

final userRF = fireStore.collection("user");

final userWrongRF = userRF.doc(_user?.email).collection("wrong_answer");

final questionPaperRF = fireStore.collection('questionPapers');
DocumentReference questionRF({
  required String paperId,
  required String questionId,
}) =>
    questionPaperRF.doc(paperId).collection("questions").doc(questionId);
