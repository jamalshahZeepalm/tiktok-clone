import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/modules/home/controllers/auth_controller.dart';
import 'package:tiktok_clone/app/modules/home/views/Auth/login_page.dart';
import 'package:tiktok_clone/app/modules/home/views/Nav%20Bar%20Screen/bottom_navbar.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
      init: AuthController(),
      builder: (controller) {
        if (controller.getUser == null) {
          return LoginScreen();
        } else {
          return BottomNavBarScreen();
        }
      },
    );
  }
}
