import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizz_app/app/common/values/app_color.dart';
import 'package:quizz_app/app/common/values/style/app_text_style.dart';
import 'package:quizz_app/app/modules/home/controller/zoom_drawer_controller.dart';

class MenuView extends GetView<MyZoomDrawerController> {
  const MenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SafeArea(
        child: Stack(
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
            Positioned(
              top: 0,
              right: 0,
              child: BackButton(
                color: AppColors.kButtonColor,
                onPressed: () {
                  controller.toogleDrawer();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20).r,
              child: Column(
                children: [
                  Obx(() => controller.user.value == null
                      ? SizedBox()
                      : Column(
                          children: [
                            SizedBox(
                              child: CircleAvatar(
                                radius: 60.52.r,
                                backgroundColor: AppColors.kButtonColor,
                                child: CircleAvatar(
                                  radius: 58.r,
                                  backgroundImage: NetworkImage(controller
                                      .user.value!.photoURL as String),
                                ),
                              ),
                            ),
                            SizedBox(width: 0.0, height: 10.h),
                            Text(
                              controller.user.value!.displayName ?? '',
                              style: AppTextStyle.semiBoldMediumStyle
                                  .copyWith(fontSize: 25.sp),
                            ),
                          ],
                        )),
                  const Spacer(flex: 1),
                  _DrawerButton(
                      icon: Icons.facebook_outlined,
                      lable: "Facebook",
                      onPressed: () => controller.facebook()),
                  Padding(
                    padding: const EdgeInsets.only(left: 30).r,
                    child: _DrawerButton(
                        icon: Icons.email,
                        lable: "Email",
                        onPressed: () => controller.email()),
                  ),
                  const Spacer(flex: 4),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10).r,
                    child: _DrawerButton(
                      icon: Icons.logout_outlined,
                      lable: "Đăng xuất",
                      onPressed: () => controller.singOut(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerButton extends StatelessWidget {
  const _DrawerButton(
      {Key? key, required this.icon, required this.lable, this.onPressed})
      : super(key: key);

  final IconData icon;
  final String lable;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 20.sp,
      ),
      label: Text(lable),
    );
  }
}
