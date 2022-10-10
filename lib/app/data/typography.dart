import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiktok_clone/app/data/colors.dart';

class CustomTextStyle {
  static TextStyle kBold = TextStyle(fontWeight: FontWeight.bold);
  static TextStyle kTextStyle25 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: ScreenUtil().setSp(25),
    color: CustomColors.buttonColor,
  );
}
