import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/modules/Models/comment_model.dart';
import 'package:tiktok_clone/app/modules/home/controllers/auth_controller.dart';
import 'package:tiktok_clone/app/modules/home/views/Database%20Helper/database_helper.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _commentList = Rx<List<Comment>>([]);
  List<Comment> get getComentList => _commentList.value;
  String postId = '';
  updatePostValue({required String id}) {
    postId = id;
    getComment();
  }

  getComment() {
    _commentList.bindStream(
      DataBaseHelper.firestore
          .collection('Videos')
          .doc(postId)
          .collection('Comments')
          .snapshots()
          .map(
        (QuerySnapshot querySnapshot) {
          List<Comment> allCommentsList = [];
          for (var element in querySnapshot.docs) {
            allCommentsList.add(Comment.fromSnap(element));
          }
          return allCommentsList;
        },
      ),
    );
  }

  commentPost({required String inputText}) async {
    try {
      if (inputText.isNotEmpty) {
        // geting user all list
        DocumentSnapshot snapshot = await DataBaseHelper.firestore
            .collection('Users')
            .doc(AuthController.authController.user!.uid)
            .get();
        var userSnapshot = (snapshot.data()! as dynamic);
        //geting all comments length
        var alldoc = await DataBaseHelper.firestore
            .collection('Videos')
            .doc(postId)
            .collection('Comments')
            .get();
        //storing all the comment length.
        var len = alldoc.docs.length;

        Comment comment = Comment(
            username: userSnapshot['userName'],
            comment: inputText.trim(),
            datePublished: DateTime.now(),
            like: [],
            profilePhoto: userSnapshot['profileImage'],
            uid: AuthController.authController.user!.uid,
            id: "comment $len");
        await DataBaseHelper.firestore
            .collection('Videos')
            .doc(postId)
            .collection('Comments')
            .doc('comment $len')
            .set(comment.toJson());
            // add coment count in video screen
        DocumentSnapshot doc = await DataBaseHelper.firestore
            .collection('Videos')
            .doc(postId)
            .get();
        await DataBaseHelper.firestore.collection('Videos').doc(postId).update({
          'commentCount': (doc.data()! as dynamic)['commentCount'] + 1,
        });
      } else {
        print('getting some error');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  likeComment(String id) async {
    String uid = AuthController.authController.user!.uid;
    DocumentSnapshot snapshot = await DataBaseHelper.firestore
        .collection('Videos')
        .doc(postId)
        .collection('Comments')
        .doc(id)
        .get();
    if ((snapshot.data()! as dynamic)['like'].contains(uid)) {
      await DataBaseHelper.firestore
          .collection('Videos')
          .doc(postId)
          .collection('Comments')
          .doc(id)
          .update({
        'like': FieldValue.arrayRemove([uid])
      });
    } else {
      await DataBaseHelper.firestore
          .collection('Videos')
          .doc(postId)
          .collection('Comments')
          .doc(id)
          .update({
        'like': FieldValue.arrayUnion([uid])
      });
    }
  }
}
