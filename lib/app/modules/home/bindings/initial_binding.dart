import 'package:get/get.dart';
import 'package:tiktok_clone/app/modules/home/controllers/auth_controller.dart';
import 'package:tiktok_clone/app/modules/home/controllers/profile_controller.dart';
import 'package:tiktok_clone/app/modules/home/controllers/upload_video_controller.dart';
import 'package:tiktok_clone/app/modules/home/controllers/video_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);

    Get.lazyPut<UploadVideoController>(() => UploadVideoController(),
        fenix: true);
    Get.lazyPut<VideoController>(() => VideoController(), fenix: true);
  }
}
