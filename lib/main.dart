import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:quizz_app/app/common/values/style/string.dart';
import 'package:quizz_app/app/modules/auth/bindings/initial_bindings.dart';
import 'package:quizz_app/app/modules/chatgpt/providers/models_provider.dart';
import 'package:quizz_app/app/routes/app_routes.dart';
import 'package:get_storage/get_storage.dart';

import 'app/modules/chatgpt/providers/chats_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  InitialBindings().dependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(390, 844),
      builder: (context, widget) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ModelsProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ChatProvider(),
          )
        ],
        child: GetMaterialApp(
          title: Strings.titleapp,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(),
          getPages: AppRoutes.routes(),
        ),
      ),
    );
  }
}
