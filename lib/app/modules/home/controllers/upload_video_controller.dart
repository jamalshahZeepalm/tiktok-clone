import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/modules/Models/video_model.dart';
import 'package:tiktok_clone/app/modules/home/views/Database%20Helper/database_helper.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  static UploadVideoController uploadVideoController = Get.find();
  Future<String> uploadVideoToFireStore({
    required String songName,
    required String caption,
    required String videoPath,
  }) async {
    String res = 'some error occure';
    try {
      String uid = DataBaseHelper.auth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await DataBaseHelper.firestore.collection('Users').doc(uid).get();
      var userSnap = (userDoc.data() as Map<String, dynamic>);
      var videoSnap = await DataBaseHelper.firestore.collection('Videos').get();
      var len = videoSnap.docs.length;

      String videoDownloadURL = await _uploadVideoToFireStorage(
        uid: "Video $len",
        videoPath: videoPath,
      );
      String tumbnail = await _uploadTumbnailToFireStorage(
        uid: "Video $len",
        videoPath: videoPath,
      );

      VideoModel videoModel = VideoModel(
        userName: userSnap['userName'],
        uid: uid,
        id: "Video $len",
        like: 0,
        commentCount: 0,
        shareCount: 0,
        songName: songName,
        caption: caption,
        videoUrl: videoDownloadURL,
        thumbnail: tumbnail,
        profilePhoto: userSnap['profileImage'],
      );
      await _toFireStore(videoModel: videoModel);
      Get.back();
      Get.back();
      Get.snackbar(
          'Uploading Video', 'Video add successfully in the Database!');
      res = 'success';
    } catch (e) {
      print(e.toString());
      res = e.toString();
    }
    return res;
  }

  Future<String> _uploadVideoToFireStorage(
      {required String uid, required String videoPath}) async {
    Reference reference =
        DataBaseHelper.storage.ref().child('Videos').child(uid);
    UploadTask uploadTask = reference.putFile(
      await _videoCompress(videoCompressPath: videoPath),
    );
    TaskSnapshot taskSnapshot = await uploadTask;
    String videoDownloadURL = await taskSnapshot.ref.getDownloadURL();
    return videoDownloadURL;
  }

  _videoCompress({required String videoCompressPath}) async {
    final compressedVideo = await VideoCompress.compressVideo(
      videoCompressPath,
      quality: VideoQuality.MediumQuality,
    );
    return compressedVideo!.file;
  }

  Future<String> _uploadTumbnailToFireStorage(
      {required String uid, required String videoPath}) async {
    Reference reference =
        DataBaseHelper.storage.ref().child('thumbnails').child(uid);
    UploadTask uploadTask = reference.putFile(
      await _getThumbnail(videoPath: videoPath),
    );
    TaskSnapshot taskSnapshot = await uploadTask;
    String tumbnailsDownloadURL = await taskSnapshot.ref.getDownloadURL();
    return tumbnailsDownloadURL;
  }

  _getThumbnail({required String videoPath}) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<void> _toFireStore({required VideoModel videoModel}) async {
    await DataBaseHelper.firestore
        .collection('Videos')
        .doc(videoModel.id)
        .set(videoModel.toMap());
  }
}
