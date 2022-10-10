import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/modules/home/views/Database%20Helper/database_helper.dart';
import 'package:tiktok_clone/app/modules/home/views/Widgets/profile_widget.dart';

import '../../../Models/user_model.dart';
import '../../controllers/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  bool isCurrentUser;
  ProfileScreen({
    Key? key,
    this.isCurrentUser = true,
    required this.uid,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return widget.isCurrentUser
        ? Obx(
            () {
              return profileController.userValue == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ProfileWidget(
                      user: profileController.userValue!,
                      isCurrentUser: widget.isCurrentUser);
            },
          )
        : FutureBuilder(
            future: DataBaseHelper().userCollection.doc(widget.uid).get(),
            builder: (context, snapshot) {
              UserModel? user =
                  UserModel.fromSnap(snapshot.data!);
              print(user.userName);
              return ProfileWidget(
                  user: user, isCurrentUser: widget.isCurrentUser);
            },
          );
  }
}
