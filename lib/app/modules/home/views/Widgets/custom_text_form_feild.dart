import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiktok_clone/app/data/colors.dart';

class CustomTextFormFeild extends StatelessWidget {
  const CustomTextFormFeild(
      {super.key,
      required this.textInputType,
      required this.validator,
      required this.onChange,
      required this.hintText,
      this.isPass = false,
      required this.preFixIcon,
      required this.textEditingController});
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final void Function(String)? onChange;
  final IconData preFixIcon;
  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: CustomColors.borderColor),
    );
    return TextFormField(
      keyboardType: textInputType,
      controller: textEditingController,
      obscureText: isPass,
      decoration: InputDecoration(
        prefixIcon: Icon(
          preFixIcon,
          color: CustomColors.kPrimaryColor,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        hintText: hintText,
      ),
      validator: validator,
      onChanged: onChange,
    );
  }
}
