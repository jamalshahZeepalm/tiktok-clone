
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiktok_clone/app/data/typography.dart';

import '../../../../data/colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onClick;
  final String title;
  final double width;
  const CustomButton({Key? key, required this.onClick, required this.title,required this.width})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: ShapeDecoration(
            color: CustomColors.buttonColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r))),
        alignment: Alignment.center,
        width: width,
        
        child: Text(
          title,
          style: CustomTextStyle.kBold,
        ),
      ),
    );
  }
}
