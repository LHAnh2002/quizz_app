import 'package:get/get.dart';
import 'package:quizz_app/app/common/services/firebase_storage_service.dart';
import 'package:quizz_app/app/modules/auth/controller/auth_controller.dart';
import 'package:quizz_app/app/modules/home/controller/home_controller.dart';
import 'package:quizz_app/app/test/getx_controller.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FirebaseStorageServica());
    Get.put(HomeController());
    Get.put(GetxControllerCache());
    Get.put(AuthController(), permanent: true);
  }
}
