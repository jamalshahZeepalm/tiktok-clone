import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/modules/home/controllers/auth_controller.dart';
import 'package:tiktok_clone/app/modules/home/controllers/upload_video_controller.dart';
import 'package:tiktok_clone/app/modules/home/views/Dasboard/personal_profile.dart';
import 'package:tiktok_clone/app/modules/home/views/Dasboard/search_screen.dart';

import '../modules/home/views/Dasboard/add_video_screen.dart';
import '../modules/home/views/Dasboard/video_feed_screen.dart';

var authcontroller = AuthController.authController;
var uploadVideoController = UploadVideoController.uploadVideoController;
// var videoController = VideoController.videoController;
List pages = [
  VideoScreen(),
  SearchScreen(),
  AddVideoScreen(),
  Center(child: Text('Messaging')),
  ProfileScreen(uid: Get.find<AuthController>().getUser!.uid),
];
