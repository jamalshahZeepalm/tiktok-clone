import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/modules/Models/user_model.dart';
import 'package:tiktok_clone/app/modules/home/views/Database%20Helper/database_helper.dart';

class SearchController extends GetxController {
    Rx<List<UserModel>?> _listOfUsers = Rx<List<UserModel>?>(null);
  List<UserModel>? get getUserList => _listOfUsers.value;
  set setListOfUsers(Rx<List<UserModel>?> val) {
    _listOfUsers = val;
  }

  searchUser({required String inputType}) {
    _listOfUsers.bindStream(
      DataBaseHelper.firestore
          .collection('Users')
          .where(
            'userName',
            isGreaterThanOrEqualTo: inputType,
          )
          .snapshots()
          .map(
        (QuerySnapshot querySnapshot) {
          List<UserModel> newList = [];
          for (var e in querySnapshot.docs) {
            newList.add(UserModel.fromSnap(e));
          }
          return newList;
        },
      ),
    );
  }
}
