import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:tiktok_clone/app/data/themes.dart';
import 'package:tiktok_clone/app/modules/home/bindings/initial_binding.dart';

import 'package:tiktok_clone/app/modules/home/views/Splash%20Screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: "Tiktok Colne",
          home: SplashScreen(),
          initialBinding: InitialBinding(),
          debugShowCheckedModeBanner: false,
          theme: CustomTheme.darkTheme,
        );
      },
    ),
  );
}
