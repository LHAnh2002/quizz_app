import 'package:get/get.dart';
import 'package:quizz_app/app/common/controller/firebase_ref/references.dart';

class FirebaseStorageServica extends GetxService {
  Future<String?> getImage([String? imgName]) async {
    if (imgName == null) {
      return null;
    }
    try {
      var urlRef = firebaseStorage
          .child("question_image")
          .child('${imgName.toLowerCase()}.png');
      var urlImg = await urlRef.getDownloadURL();
      return urlImg;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
