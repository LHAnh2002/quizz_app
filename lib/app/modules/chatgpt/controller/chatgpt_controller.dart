import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizz_app/app/modules/chatgpt/models/chat_model.dart';
import 'package:quizz_app/app/modules/chatgpt/widgets/text_widget.dart';

import '../../../common/values/app_color.dart';
import '../../../common/values/style/app_text_style.dart';
import '../models/models_model.dart';
import '../providers/chats_provider.dart';
import '../providers/models_provider.dart';
import '../services/api_service.dart';

class ChatgptController extends GetxController {
  final isTyping = false.obs;
  late TextEditingController textEditingController;
  late FocusNode focusNode;
  late ScrollController scrollController;
  List<ChatModel> chatList = [];

  @override
  void onInit() {
    scrollController = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    textEditingController.dispose();
    focusNode.dispose();
    super.onClose();
  }

  void scrollListToEND() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(seconds: 3),
      curve: Curves.easeInOut,
    );
  }

  

  Future<void> sendMessage(
      {required ModelsProvider modelsProvider,
      required ChatProvider chatProvider}) async {
    log("Model: ${modelsProvider.getCurrenTmodels}");
    if (isTyping.value) {
      Get.snackbar(
        "Thông báo!",
        "Bạn không thể gửi nhiều tin nhắn cùng một lúc!",
        backgroundColor: AppColors.kButtonColor,
        titleText: Text(
          "Thông báo",
          style: AppTextStyle.semiBoldMediumStyle.copyWith(
            color: AppColors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        messageText: Text(
          "Bạn không thể gửi nhiều tin nhắn cùng một lúc!",
          style: AppTextStyle.semiBoldMediumStyle.copyWith(
            color: AppColors.white,
            fontSize: 15.sp,
          ),
        ),
      );
      return;
    }
    if (textEditingController.text.isEmpty) {
      Get.snackbar(
        "Thông báo!",
        "Hãy nhập yêu cầu của bạn!",
        backgroundColor: AppColors.kButtonColor,
        titleText: Text(
          "Thông báo",
          style: AppTextStyle.semiBoldMediumStyle.copyWith(
            color: AppColors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        messageText: Text(
          "Hãy nhập yêu cầu của bạn!",
          style: AppTextStyle.semiBoldMediumStyle.copyWith(
            color: AppColors.white,
            fontSize: 15.sp,
          ),
        ),
      );
      return;
    }
    try {
      String msg = textEditingController.text;
      isTyping.value = true;
      // chatList.add(ChatModel(msg: textEditingController.text, chatIndex: 0));
      chatProvider.addUserMessage(msg: msg);
      textEditingController.clear();
      log("msg ${msg}");
      update();
      focusNode.unfocus();
      await chatProvider.sendMessageAndGetAnswers(
        msg: msg,
        chosenModelID: modelsProvider.getCurrenTmodels,
      );
      update();
    } catch (e) {
      debugPrint("Error: $e");
      Get.snackbar(
        "Thông báo!",
        "${e.toString()}",
        backgroundColor: AppColors.kButtonColor,
        titleText: Text(
          "Thông báo",
          style: AppTextStyle.semiBoldMediumStyle.copyWith(
            color: AppColors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        messageText: Text(
          "${e.toString()}",
          style: AppTextStyle.semiBoldMediumStyle.copyWith(
            color: AppColors.white,
            fontSize: 15.sp,
          ),
        ),
      );
    } finally {
      scrollListToEND();
      isTyping.value = false;
    }
  }
}
