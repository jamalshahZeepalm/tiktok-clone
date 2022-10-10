import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/modules/Models/user_model.dart';
import 'package:tiktok_clone/app/modules/Models/video_model.dart';
import 'package:tiktok_clone/app/modules/home/controllers/auth_controller.dart';
import 'package:tiktok_clone/app/modules/home/views/Database%20Helper/database_helper.dart';

class ProfileController extends GetxController {
  Rx<UserModel?> user = Rx<UserModel?>(null);
  Rx<int> userFollowers = 0.obs;
  Rx<int> userFollowing = 0.obs;
  Rx<List<VideoModel>?> userVideo = Rx<List<VideoModel>?>(null);

  List<VideoModel>? get userVideoValue => userVideo.value;
  UserModel? get userValue => user.value;
  int get userFollowingVal => userFollowing.value;
  int get userFollowersVal => userFollowing.value;
  Rx<int> likes = 0.obs;
  int get userLikes => likes.value;

  Stream<UserModel?> userStream() {
    return DataBaseHelper()
        .userCollection
        .doc(Get.find<AuthController>().getUser!.uid)
        .snapshots()
        .map(
            (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }

  Stream<List<VideoModel>?> userVideoStream() {
    return DataBaseHelper()
        .videosCollection
        .where('uid', isEqualTo: Get.find<AuthController>().getUser!.uid)
        .snapshots()
        .map((event) {
      List<VideoModel>? videos = [];
      for (var element in event.docs) {
        videos.add(VideoModel.fromMap(element.data() as Map<String, dynamic>));
      }
      return videos;
    });
  }

  Stream<int> userFollowingStream() {
    return DataBaseHelper()
        .followingCollection(Get.find<AuthController>().getUser!.uid)
        .snapshots()
        .map((event) => event.docs.isNotEmpty ? event.docs.length : 0);
  }

  Stream<int> userFollowersStream() {
    return DataBaseHelper()
        .followersCollection(Get.find<AuthController>().getUser!.uid)
        .snapshots()
        .map((event) => event.docs.isNotEmpty ? event.docs.length : 0);
  }

  Stream<int> usersLike() {
    return DataBaseHelper()
        .likesCollection(Get.find<AuthController>().getUser!.uid)
        .snapshots()
        .map((event) => event.docs.isNotEmpty ? event.docs.length : 0);
  }

  @override
  void onInit() {
    user.bindStream(userStream());
    userVideo.bindStream(userVideoStream());
    likes.bindStream(usersLike());
    super.onInit();
  }

  Future<void> likeVideo(String videoId) async {
    try {
      await DataBaseHelper()
          .videosCollection
          .doc(videoId)
          .update({'like': FieldValue.increment(1)});
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> dislikevideo(String videoId) async {
    try {
      await DataBaseHelper()
          .videosCollection
          .doc(videoId)
          .update({'like': FieldValue.increment(-1)});
    } on Exception catch (e) {
      print(e);
    }
  }
}
