import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:quizz_app/app/common/values/app_color.dart';
import 'package:quizz_app/app/common/values/style/app_text_style.dart';
import 'package:quizz_app/app/common/values/style/string.dart';
import 'package:quizz_app/app/modules/chatgpt/controller/chatgpt_controller.dart';
import 'package:quizz_app/app/modules/chatgpt/models/chat_model.dart';
import 'package:quizz_app/app/modules/chatgpt/widgets/chat_widget.dart';
import '../providers/chats_provider.dart';
import '../providers/models_provider.dart';
import '../widgets/drop_down.dart';
import '../widgets/text_widget.dart';

class ChatGptView extends GetView<ChatgptController> {
  const ChatGptView({Key? key}) : super(key: key);
  static const String routeName = '/chatgptview';

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context, listen: false);
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_top.png",
              width: 500.w * 0.3,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_bottom.png",
              width: 300.w * 0.3,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 10,
                  ).r,
                  child: SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        InkWell(
                          onTap: () => Get.back(),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 25.sp,
                          ),
                        ),
                        Text(
                          Strings.chatgpt,
                          style: AppTextStyle.semiBoldMediumStyle.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.sp,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.bottomSheet(
                              backgroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(18.w),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: TextWidget(
                                        label: "Mô hình đã chọn:",
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                    const Flexible(
                                      flex: 2,
                                      child: ModelsDrowDownWidget(),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.more_vert_outlined,
                            size: 25.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: GetBuilder<ChatgptController>(
                    builder: (_) {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        controller: controller.scrollController,
                        itemCount: chatProvider.getchatList.length,
                        itemBuilder: (context, index) {
                          return ChatWidget(
                            chatIndex:
                                chatProvider.getchatList[index].chatIndex,
                            msg: chatProvider.getchatList[index].msg,
                          );
                        },
                      );
                    },
                  ),
                ),
                Obx(() {
                  if (controller.isTyping.value) {
                    return SpinKitThreeBounce(
                      color: AppColors.black,
                      size: 18.sp,
                    );
                  } else {
                    return Container();
                  }
                }),
                SizedBox(width: 0.0, height: 15.w),
                Material(
                  color: AppColors.kBlackDot,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15).r,
                          child: TextField(
                            focusNode: controller.focusNode,
                            controller: controller.textEditingController,
                            onSubmitted: (value) async {
                              await controller.sendMessage(
                                  modelsProvider: modelsProvider,
                                  chatProvider: chatProvider);
                            },
                            decoration: const InputDecoration.collapsed(
                              hintText: "Làm thế nào để tôi giúp bạn!",
                              hintStyle: TextStyle(
                                  // color: Colors.black,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            await controller.sendMessage(
                                modelsProvider: modelsProvider,
                                chatProvider: chatProvider);
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.black,
                          ))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
