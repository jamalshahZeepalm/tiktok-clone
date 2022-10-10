import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/app/modules/home/views/Dasboard/confirm_screen.dart';

import 'package:tiktok_clone/app/modules/home/views/Widgets/custom_button.dart';

class AddVideoScreen extends StatefulWidget {
  const AddVideoScreen({super.key});

  @override
  State<AddVideoScreen> createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 140.w,
          height: 50.h,
          child: CustomButton(
            onClick: () => showOptionDailog(context: context),
            title: 'Add Video',
            width: 140.w,
          ),
        ),
      ),
    );
  }

  Future<void> selectVideo({required ImageSource source}) async {
    XFile? pick = await ImagePicker()
        .pickVideo(source: source, maxDuration: Duration(seconds: 3));
    if (pick != null) {
      Get.to(
        () => ConfirmScreen(videoFile: File(pick.path), videoPath: pick.path),
      );
    }
  }

  showOptionDailog({required BuildContext context}) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            SimpleDialogOption(
              onPressed: () async {
                await selectVideo(source: ImageSource.gallery);
              },
              child: Row(
                children: [
                  Icon(Icons.image),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('From Gallery'),
                  ),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                selectVideo(source: ImageSource.camera);
              },
              child: Row(
                children: [
                  Icon(Icons.camera_alt),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('From Camera'),
                  ),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () => Get.back(),
              child: Row(
                children: [
                  Icon(Icons.cancel_outlined),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Cancel'),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
