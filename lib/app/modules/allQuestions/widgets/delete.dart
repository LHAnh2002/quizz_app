import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizz_app/app/common/values/app_color.dart';
import 'package:quizz_app/app/common/values/style/app_text_style.dart';
import 'package:quizz_app/app/modules/allQuestions/widgets/TexOverviewScreen_word.dart';
import 'package:quizz_app/app/modules/widgets/app_cicle_button.dart';
import 'package:quizz_app/app/modules/wrongSentence/controller/wrong_controller.dart';

class DeleteCustomAppbar extends GetView<WrongController>
    implements PreferredSizeWidget {
  const DeleteCustomAppbar(
      {Key? key,
      this.title = '',
      this.titleWidget,
      this.showActionIcon = false,
      this.leading,
      this.onMenuActionTap})
      : super(key: key);
  final String title;
  final Widget? titleWidget;
  final Widget? leading;
  final bool showActionIcon;
  final VoidCallback? onMenuActionTap;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20).r,
        child: Stack(
          children: [
            Positioned.fill(
              child: titleWidget == null
                  ? Center(
                      child: Text(
                        title,
                        style: AppTextStyle.semiBoldMediumStyle
                            .copyWith(color: Colors.white),
                      ),
                    )
                  : Center(
                      child: titleWidget,
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                leading ??
                    Transform.translate(
                      offset: const Offset(-14, 0),
                      child: const BackButton(
                        color: Colors.white,
                      ),
                    ),
                if (showActionIcon)
                  Transform.translate(
                    offset: const Offset(2, 0),
                    child: AppCicleButton(
                      ontap: onMenuActionTap ?? () => controller.deleteAnswer(),
                      child: Icon(
                        Icons.delete_outline,
                        size: 35.sp,
                        color: AppColors.white,
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.maxFinite, 80);
}
