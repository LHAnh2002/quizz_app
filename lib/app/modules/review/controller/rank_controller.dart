import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:quizz_app/app/common/controller/firebase_ref/loading_status.dart';
import 'package:quizz_app/app/common/controller/firebase_ref/references.dart';
import 'package:quizz_app/app/modules/review/models/rank_models.dart';

class RankController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;
  final userList = <RankModer>[].obs;
  Rxn<RankModer> currentQuestion = Rxn<RankModer>();
  @override
  void onReady() {
    loadData();
    super.onReady();
  }

  Future<void> loadData() async {
    loadingStatus.value = LoadingStatus.loading;
    await Future.delayed(Duration(seconds: 1));
    try {
      final querySnapshot = await userRF.get();
      final user = querySnapshot.docs
          .map((snapshot) => RankModer.fromSnapshot(snapshot))
          .toList();
      userList.addAll(user);
      for (var userID in userList) {
        final querySnapshot = await userRF
            .doc(userID.id)
            .collection('rank')
            .orderBy('points', descending: true)
            .limit(1)
            .get();
        final rank = querySnapshot.docs
            .map((snapshot) => Rank.fromSnapshot(snapshot))
            .toList();
        userID.rank!.assignAll(rank);
      }
      final topUsers = userList.where((user) => user.rank!.isNotEmpty).toList()
        ..sort((a, b) => b.rank!.first.points.compareTo(a.rank!.first.points));
      final top10Users = topUsers.take(10).toList();
      userList.assignAll(top10Users);
     
      if (userList.isNotEmpty) {
        loadingStatus.value = LoadingStatus.completed;
        currentQuestion.value = userList[0];
        if (kDebugMode) {
          print(userList[0].rank![0].points);
        }
      } else {
        loadingStatus.value = LoadingStatus.error;
      }
      update();
    } catch (e) {
      if (kDebugMode) {
        print("lỗi: " + e.toString());
      }
    }
  }
}
