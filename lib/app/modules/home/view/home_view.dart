import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:quizz_app/app/common/values/app_color.dart';
import 'package:quizz_app/app/modules/home/controller/zoom_drawer_controller.dart';
import 'package:quizz_app/app/modules/home/view/menu_view.dart';
import 'package:quizz_app/app/modules/home/widgets/button_widget.dart';
import 'package:quizz_app/app/modules/widgets/app_cicle_button.dart';
import '../controller/home_controller.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class HomeView extends GetView<MyZoomDrawerController> {
  const HomeView({Key? key}) : super(key: key);
  static const String home = '/home';
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();
    return Scaffold(
      body: GetBuilder<MyZoomDrawerController>(
        builder: (_) {
          return ZoomDrawer(
            borderRadius: 10,
            showShadow: true,
            style: DrawerStyle.defaultStyle,
            menuBackgroundColor: AppColors.white.withOpacity(0.5),
            slideWidth: MediaQuery.of(context).size.width * 0.8,
            angle: 0,
            controller: _.zoomDrawerController,
            menuScreen: const MenuView(),
            mainScreen: SafeArea(
              child: Stack(
                alignment: Alignment.center,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, top: 17, right: 15)
                                .r,
                        child: AppCicleButton(
                          ontap: controller.toogleDrawer,
                          child: Icon(
                            Icons.clear_all_rounded,
                            size: 35.sp,
                            color: AppColors.kButtonColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 20, top: 20)
                              .r,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                const Radius.elliptical(20, 20).r),
                          ),
                          child: const ButtonWidget(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
