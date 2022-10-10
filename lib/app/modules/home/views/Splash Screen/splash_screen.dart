import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tiktok_clone/app/modules/home/views/Auth/auth_wrapper.dart';

import '../../../../data/colors.dart';
import '../../../../data/image_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
          splashIconSize: 160.h,
          backgroundColor: CustomColors.backgroundColor,
          splash: SvgPicture.asset(
            CustomAssets.kTiktok,
            color: CustomColors.kPrimaryColor,
            width: 400.w,
            height: 400.h,
          ),
          nextScreen: AuthWrapper()),
    );
  }
}
