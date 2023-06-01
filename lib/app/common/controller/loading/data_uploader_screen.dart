import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizz_app/app/common/controller/firebase_ref/loading_status.dart';
import 'package:quizz_app/app/common/controller/loading/question_papers/data_uploader.dart';

class DataUploaderScreen extends StatelessWidget {
  DataUploaderScreen({Key? key}) : super(key: key);
  DataUploader controller = Get.put(DataUploader());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() => Text(
            controller.loadingStatus.value == LoadingStatus.completed
                ? "Tải thành công"
                : 'Đang Tải...')),
      ),
    );
  }
}
