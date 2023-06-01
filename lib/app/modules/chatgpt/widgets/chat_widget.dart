import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizz_app/app/modules/chatgpt/services/assets_manager.dart';
import 'package:quizz_app/app/modules/chatgpt/widgets/text_widget.dart';

import '../../../common/values/app_color.dart';
import '../../home/controller/zoom_drawer_controller.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({Key? key, required this.msg, required this.chatIndex})
      : super(key: key);

  final String msg;
  final int chatIndex;
  @override
  Widget build(BuildContext context) {
    final MyZoomDrawerController controller = Get.find();
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10).r,
      child: Container(
        padding:
            const EdgeInsets.only(left: 13, right: 13, top: 9, bottom: 9).r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(const Radius.circular(10).r),
          color: chatIndex == 0
              ? AppColors.kBlackDot
              : AppColors.primatryColorDark,
        ),
        child: chatIndex == 0
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextWidget(label: msg),
                  SizedBox(width: 8.w, height: 0.0),
                  controller.user.value!.photoURL != null
                      ? CircleAvatar(
                          radius: 15.r,
                          backgroundImage: NetworkImage(
                              controller.user.value!.photoURL as String),
                        )
                      : Image.asset(
                          AssetsManager.userImage,
                          width: 30.w,
                          height: 30.w,
                        )
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    AssetsManager.botImage,
                    width: 35.w,
                    height: 35.w,
                  ),
                  SizedBox(width: 8.w, height: 0.0),
                  Expanded(
                    child: GestureDetector(
                      onLongPress: () {
                        controller.copyText(msg.trim());
                      },
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText(msg.trim()),
                        ],
                        isRepeatingAnimation: false,
                        repeatForever: false,
                        displayFullTextOnTap: true,
                        totalRepeatCount: 1,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
