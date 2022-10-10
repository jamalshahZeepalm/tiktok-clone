import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/data/consts.dart';
import 'package:tiktok_clone/app/data/typography.dart';
import 'package:tiktok_clone/app/modules/home/views/Auth/signup_page.dart';
import 'package:tiktok_clone/app/modules/home/views/Widgets/custom_button.dart';

import '../../../../data/colors.dart';
import '../../../../data/image_path.dart';
import '../Widgets/custom_text_form_feild.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        width: double.infinity.w,
        child: Form(
          key: formKey,
          child:
              Column(
                mainAxisAlignment: ,
                crossAxisAlignment: CrossAxisAlignment.start,
              
               children: [
            Flexible(
              flex: 1,
              child: Container(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                CustomAssets.kTiktok,
                color: CustomColors.kPrimaryColor,
                width: 100.w,
                height: 100.h,
              ),
            ),
            SizedBox(
              height: 23.h,
            ),
            Text(
              'Login',
              style: CustomTextStyle.kTextStyle25,
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomTextFormFeild(
                validator: (val) {
                  if (val!.isEmpty) {
                    return "This field can't be empty";
                  }
                  return null;
                },
                textInputType: TextInputType.emailAddress,
                onChange: (v) {},
                hintText: 'enter your email',
                textEditingController: _emailEditingController,
                preFixIcon: Icons.email),
            SizedBox(
              height: 24.h,
            ),
            CustomTextFormFeild(
                isPass: true,
                textInputType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "This field can't be empty";
                  }
                  return null;
                },
                onChange: (v) {},
                hintText: 'enter your password',
                textEditingController: _passwordEditingController,
                preFixIcon: Icons.lock),
            SizedBox(
              height: 24.h,
            ),
            CustomButton(
              onClick: () {
                if (formKey.currentState!.validate()) {
                  authcontroller.loginUser(
                      email: _emailEditingController.text,
                      password: _passwordEditingController.text);
                }
                Get.back();
              },
              title: 'Login',
              width: double.infinity.w,
            ),
            SizedBox(
              height: 12.h,
            ),
            Flexible(
              flex: 1,
              child: Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: const Text("Don't have an Account?"),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => const SignUpScreen());
                    },
                    child: Text(
                      ' SignUp',
                      style: CustomTextStyle.kBold,
                    ),
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
  }
}
