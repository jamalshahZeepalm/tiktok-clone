import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/modules/Models/video_model.dart';
import 'package:tiktok_clone/app/modules/home/controllers/auth_controller.dart';
import 'package:tiktok_clone/app/modules/home/views/Database%20Helper/database_helper.dart';

class VideoController extends GetxController {
  Rx<List<VideoModel>?> _videoList = Rx<List<VideoModel>?>(null);
  List<VideoModel>? get getVideoList => _videoList.value;

  @override
  void onInit() {
    _videoList.bindStream(userVideoStream());
    super.onInit();
  }

  Stream<List<VideoModel>?> userVideoStream() {
    return DataBaseHelper().videosCollection.snapshots().map((event) {
      List<VideoModel>? videos = [];
      for (var element in event.docs) {
        videos.add(VideoModel.fromMap(element.data() as Map<String, dynamic>));
      }
      return videos;
    });
  }

  likeVideo(String id) async {
    DocumentSnapshot doc =
        await DataBaseHelper.firestore.collection('Videos').doc(id).get();

    String uid = AuthController.authController.user!.uid;
    if ((doc.data()! as dynamic)['like'].contains(uid)) {
      await DataBaseHelper.firestore.collection('Videos').doc(id).update({
        'like': FieldValue.arrayRemove([uid])
      });
    } else {
      await DataBaseHelper.firestore.collection('Videos').doc(id).update({
        'like': FieldValue.arrayUnion([uid])
      });
    }
  }
}
