// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:tiktok_clone/app/modules/Models/user_model.dart';
import 'package:tiktok_clone/app/modules/home/controllers/profile_controller.dart';
import 'package:tiktok_clone/app/modules/home/views/Database%20Helper/database_helper.dart';

import '../../../../data/colors.dart';
import '../../../../data/consts.dart';
import '../../controllers/auth_controller.dart';

class ProfileWidget extends StatefulWidget {
  UserModel user;
  bool isCurrentUser;
  ProfileWidget({
    Key? key,
    required this.user,
    required this.isCurrentUser,
  }) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

ProfileController profileController = Get.find<ProfileController>();

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Icon(
            Icons.person_add_alt_1_outlined,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.more_horiz),
          ),
        ],
        centerTitle: true,
        title: Text(
          widget.user.userName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: widget.user.profileImage,
                            height: 100,
                            width: 100,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      widget.user.bio,
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            widget.isCurrentUser
                                ? Text(
                                    profileController.userFollowingVal
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : FutureBuilder(
                                    future: DataBaseHelper()
                                        .followingCollection(widget.user.uid)
                                        .get(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return SizedBox();
                                      }
                                      int following =
                                          snapshot.data?.docs.length ?? 0;
                                      return Text(
                                        following.toString(),
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    },
                                  ),
                            SizedBox(height: 5.h),
                            Text(
                              'Following',
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          color: Colors.black54,
                          width: 1.w,
                          height: 15.h,
                          margin: EdgeInsets.symmetric(
                            horizontal: 10.w,
                          ),
                        ),
                        // follower hai
                        Column(
                          children: [
                            widget.isCurrentUser
                                ? Text(
                                    profileController.userFollowersVal
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : FutureBuilder(
                                    future: DataBaseHelper()
                                        .followersCollection(widget.user.uid)
                                        .get(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return SizedBox();
                                      }
                                      int followers =
                                          snapshot.data?.docs.length ?? 0;
                                      return Text(
                                        followers.toString(),
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    },
                                  ),
                            SizedBox(height: 5.h),
                            Text(
                              'Followers',
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          color: Colors.black54,
                          width: 1.w,
                          height: 15.h,
                          margin: EdgeInsets.symmetric(
                            horizontal: 10.w,
                          ),
                        ),
                        // Likes,
                        Column(
                          children: [
                            widget.isCurrentUser
                                ? Text(
                                    '1',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : FutureBuilder(
                                    future: DataBaseHelper()
                                        .followersCollection(widget.user.uid)
                                        .get(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return SizedBox();
                                      }
                                      // VideoModel videoModel =
                                      //     VideoModel.fromSnap(snapshot.data!
                                      //         as DocumentSnapshot);
                                      return Text(
                                        '1',
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    },
                                  ),
                            SizedBox(height: 5.h),
                            Text(
                              'Likes',
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      //nahi howa
                      height: 20.h,
                    ),
                    widget.isCurrentUser
                        ? GestureDetector(
                            onTap: () {
                              authcontroller.logoutUser();
                            },
                            child: Container(
                              width: 160.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: CustomColors.buttonColor,
                                border: Border.all(
                                  color: Colors.black12,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Sign Out',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      color: CustomColors.kPrimaryColor),
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 160.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: widget.user.uid !=
                                        Get.find<AuthController>().getUser!.uid
                                    ? CustomColors.borderColor
                                    : Colors.blue,
                                border: Border.all(
                                  color: Colors.black12,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  widget.user.uid !=
                                          Get.find<AuthController>()
                                              .getUser!
                                              .uid
                                      ? 'UnFollow'
                                      : 'Follow',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      color: CustomColors.kPrimaryColor),
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 25.w,
                    ),
                    // GridView.builder(
                    //   shrinkWrap: true,
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   itemCount: con.user['thumbnail'].length,
                    //   gridDelegate:
                    //       const SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 2,
                    //     childAspectRatio: 1,
                    //     crossAxisSpacing: 5,
                    //   ),
                    //   itemBuilder: (context, index) {
                    //     String thumbnail = con.user['thumbnail'][index];
                    //     return CachedNetworkImage(
                    //       imageUrl: thumbnail,
                    //       fit: BoxFit.cover,
                    //     );
                    //   },
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
