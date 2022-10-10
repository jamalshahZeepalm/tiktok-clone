import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/data/consts.dart';
import 'package:tiktok_clone/app/modules/home/views/Widgets/custom_text_form_feild.dart';

import '../../../../data/typography.dart';
import '../Widgets/custom_button.dart';
import 'login_page.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _userNameEditingController =
      TextEditingController();
  final TextEditingController _bioEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    authcontroller.setImage = Rx<File?>(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          width: double.infinity.w,
          child: Form(
            key: formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70.h,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      authcontroller.getImage != null
                          ? CircleAvatar(
                              radius: 64.r,
                              backgroundImage:
                                  FileImage(authcontroller.getImage!),
                            )
                          : CircleAvatar(
                              radius: 64.r,
                              backgroundImage: const NetworkImage(
                                'https://www.pngitem.com/pimgs/m/35-350426_profile-icon-png-default-profile-picture-png-transparent.png',
                                scale: 1.0,
                              ),
                            ),
                      Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                          onPressed: () async {
                            await authcontroller.imagePick();
                            setState(() {});
                          },
                          icon: const Icon(Icons.add_a_photo),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    'Register',
                    style: CustomTextStyle.kTextStyle25,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  CustomTextFormFeild(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "This field can't be empty";
                        }
                        return null;
                      },
                      onChange: (v) {},
                      textInputType: TextInputType.text,
                      hintText: 'enter your user-name',
                      textEditingController: _userNameEditingController,
                      preFixIcon: Icons.person),
                  SizedBox(
                    height: 24.h,
                  ),
                  CustomTextFormFeild(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "This field can't be empty";
                        }
                        return null;
                      },
                      onChange: (v) {},
                      hintText: 'enter your Bio',
                      textInputType: TextInputType.text,
                      textEditingController: _bioEditingController,
                      preFixIcon: Icons.biotech),
                  SizedBox(
                    height: 24.h,
                  ),
                  CustomTextFormFeild(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "This field can't be empty";
                        }
                        return null;
                      },
                      onChange: (v) {},
                      textInputType: TextInputType.emailAddress,
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
                    onClick: () async {
                      if (formKey.currentState!.validate()) {
                        await authcontroller.registerUser(
                            username: _userNameEditingController.text,
                            bio: _bioEditingController.text,
                            email: _emailEditingController.text,
                            password: _passwordEditingController.text,
                            image: authcontroller.getImage!);
                      }

                      Get.back();
                    },
                    title: 'Sign Up',
                    width: double.infinity.w,
                  ),
                  SizedBox(
                    height: 64.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: const Text("Have an Account?"),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => const LoginScreen());
                          },
                          child: Text(
                            ' Login',
                            style: CustomTextStyle.kBold,
                          ),
                        ),
                      )
                    ],
                  )
                ]),
          ),
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
