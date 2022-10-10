import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiktok_clone/app/data/colors.dart';
import 'package:tiktok_clone/app/data/consts.dart';
import 'package:tiktok_clone/app/modules/home/views/Widgets/custom_text_form_feild.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;
  const ConfirmScreen(
      {super.key, required this.videoFile, required this.videoPath});

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;
  final TextEditingController _songEditingController = TextEditingController();
  final TextEditingController _captionEditingController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.file(widget.videoFile);
    controller.initialize();
    controller.play();
    controller.setVolume(1);

    controller.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final heght = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 36.h,
            ),
            SizedBox(
              height: heght / 1.5,
              width: width,
              child: VideoPlayer(controller),
            ),
            SizedBox(
              height: 10.h,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomTextFormFeild(
                        textInputType: TextInputType.text,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "This field can't be empty";
                          }
                          return null;
                        },
                        onChange: (onChange) {},
                        hintText: 'Song Name',
                        preFixIcon: Icons.music_note,
                        textEditingController: _songEditingController,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      CustomTextFormFeild(
                        textInputType: TextInputType.text,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "This field can't be empty";
                          }
                          return null;
                        },
                        onChange: (val) {},
                        hintText: 'Caption',
                        preFixIcon: Icons.closed_caption,
                        textEditingController: _captionEditingController,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            uploadVideo();
                          }
                        },
                        child: Container(
                          width: width,
                          height: 50.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: CustomColors.buttonColor,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: isLoading? CircularProgressIndicator(color: CustomColors.kPrimaryColor,): Text(
                            'Share',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  uploadVideo() async {
    setState(() {
      isLoading = true;
    });
    String res = await uploadVideoController.uploadVideoToFireStore(
        songName: _songEditingController.text,
        caption: _captionEditingController.text,
        videoPath: widget.videoPath);

    if (res == 'success') {
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }
}
