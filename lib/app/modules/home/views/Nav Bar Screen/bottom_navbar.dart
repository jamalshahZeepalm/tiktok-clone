import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/data/colors.dart';
import 'package:tiktok_clone/app/data/consts.dart';
import 'package:tiktok_clone/app/modules/home/controllers/profile_controller.dart';
import 'package:tiktok_clone/app/modules/home/views/Widgets/custom_icon.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (uc) {
          return Scaffold(
            body: pages[pageIndex],
            bottomNavigationBar: BottomNavigationBar(
                backgroundColor: CustomColors.backgroundColor,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: CustomColors.buttonColor,
                unselectedItemColor: CustomColors.kPrimaryColor,
                currentIndex: pageIndex,
                onTap: (index) {
                  setState(() {
                    pageIndex = index;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                        size: 30.sp,
                      ),
                      label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.search,
                        size: 30.sp,
                      ),
                      label: 'Search'),
                  BottomNavigationBarItem(icon: CustomIcon(), label: ''),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.message,
                        size: 30.sp,
                      ),
                      label: 'Messge'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person,
                        size: 30.sp,
                      ),
                      label: 'Person')
                ]),
          );
        });
  }
}
