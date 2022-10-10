import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiktok_clone/app/data/colors.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45.w,
      height: 30.h,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10.w),
            width: 38.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Color.fromARGB(
                  255,
                  250,
                  45,
                  108,
                )),
          ),
          Container(
            margin: EdgeInsets.only(right: 10.w),
            width: 38.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Color.fromARGB(
                  255,
                  32,
                  211,
                  234,
                )),
          ),
          Center(
            child: Container(
              height: double.infinity.h,
              width: 38.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: CustomColors.kPrimaryColor,
              ),
              child: Icon(
                Icons.add,
                color: CustomColors.backgroundColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
