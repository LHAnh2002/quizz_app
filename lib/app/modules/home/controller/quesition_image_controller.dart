import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quizz_app/app/common/controller/firebase_ref/references.dart';
import 'package:quizz_app/app/common/models/question_pape_moder.dart';
import 'package:quizz_app/app/common/services/firebase_storage_service.dart';
import 'package:quizz_app/app/modules/Testkit/view/test_kill_question.dart';
import 'package:quizz_app/app/modules/auth/controller/auth_controller.dart';
import 'package:quizz_app/app/modules/randomTopic/view/random_topic_view.dart';
import 'package:quizz_app/app/modules/wrongSentence/view/wrong_Sentence_view.dart';

class QuestionImageController extends GetxController {
  final allImgImage = <String>[].obs;
  final allImage = <Questions>[].obs;
  @override
  void onReady() {
    getAllImage();
    super.onReady();
  }

  Future<void> getAllImage() async {
    try {
      // UserCredential userCredential =
      //     await FirebaseAuth.instance.signInAnonymously();
      // Thực hiện các hoạt động liên quan đến Firebase Storage ở đây

      QuerySnapshot<Map<String, dynamic>> data =
          await questionPaperRF.doc("ppr001").collection("questions").get();
      final imgList =
          data.docs.map((paper) => Questions.formSnapsort(paper)).toList();
      allImage.assignAll(imgList);

      for (var paper in imgList) {
        if (paper.imageUrl == null) {
          continue; // bỏ qua phần tử rỗng
        }
        final imgUrl =
            await Get.find<FirebaseStorageServica>().getImage(paper.imageUrl);
        paper.imageUrl = imgUrl;
      }
      allImage.assignAll(imgList);
    } catch (e) {
      print(e);
    }
  }

  void navigateToQuestions({bool tryAgain = false}) {
    AuthController _authController = Get.find();
    if (_authController.isLoggedIn()) {
      if (tryAgain) {
        Get.back();
        Get.toNamed(RandomTopicView.routesname, preventDuplicates: false);
      } else {
        Get.toNamed(RandomTopicView.routesname);
      }
    } else {
      _authController.showLoginAlertDialogue();
    }
  }

  void navigateToTestKillQuestions({bool tryAgain = false}) {
    AuthController _authController = Get.find();
    if (_authController.isLoggedIn()) {
      if (tryAgain) {
        Get.back();
        Get.toNamed(TestKillQuestion.routesname, preventDuplicates: false);
      } else {
        Get.toNamed(TestKillQuestion.routesname);
      }
    } else {
      _authController.showLoginAlertDialogue();
    }
  }

  void navigateToQuestionsWrong({bool tryAgain = false}) {
    AuthController _authController = Get.find();
    if (_authController.isLoggedIn()) {
      if (tryAgain) {
        Get.back();
        Get.toNamed(WrongSentenceView.routesname, preventDuplicates: false);
      } else {
        Get.toNamed(WrongSentenceView.routesname);
      }
    } else {
      _authController.showLoginAlertDialogue();
    }
  }
}
