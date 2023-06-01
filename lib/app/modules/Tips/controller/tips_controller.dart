import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quizz_app/app/common/controller/firebase_ref/references.dart';
import 'package:quizz_app/app/modules/Tips/models/tips_models.dart';

class TipsController extends GetxController with SingleGetTickerProviderMixin {
  late TabController tabController;

  final questionsList = <TipsModels>[].obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 0, vsync: this);
  }

  @override
  void onReady() async {
    await loadData();
    tabController = TabController(length: questionsList.length, vsync: this);
    ever(questionsList, (_) {
      tabController = TabController(length: questionsList.length, vsync: this);
      update();
    });
    super.onReady();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  Future<void> loadData() async {
    try {
      final jsonString = box.read('tipsList');
      if (jsonString != null) {
        final jsonData = json.decode(jsonString);
        final allQuestions = (jsonData as List<dynamic>)
            .map((question) => TipsModels.fromJson(question))
            .toList();
        questionsList.assignAll(allQuestions);
      }
      update();
    } catch (e) {
      if (kDebugMode) {
        print("lỗi: " + e.toString());
      }
    }
  }
}
