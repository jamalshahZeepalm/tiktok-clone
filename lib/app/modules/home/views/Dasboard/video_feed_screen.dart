import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/data/consts.dart';
import 'package:tiktok_clone/app/modules/home/controllers/auth_controller.dart';
import 'package:tiktok_clone/app/modules/home/controllers/profile_controller.dart';
import 'package:tiktok_clone/app/modules/home/views/Dasboard/comment_screen.dart';

import '../../controllers/video_controller.dart';
import '../Widgets/custom_cirleAnimation.dart';
import '../Widgets/custom_video_playr_item.dart';

class VideoScreen extends StatelessWidget {
  VideoScreen({Key? key}) : super(key: key);

  final VideoController videoController = Get.find<VideoController>();
  final ProfileController profileController =Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Obx(() {
        return videoController.getVideoList?.isEmpty == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : PageView.builder(
                itemCount: videoController.getVideoList!.length,
                controller: PageController(initialPage: 0, viewportFraction: 1),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  var snapshot = videoController.getVideoList![index];
                  return Stack(
                    children: [
                      VideoPlayerItem(videoUrl: snapshot.videoUrl),
                      Column(
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          snapshot.userName,
                                        ),
                                        Text(
                                          snapshot.caption,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.music_note,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              snapshot.songName,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  margin: EdgeInsets.only(top: size.height / 5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      buildProfile(
                                        snapshot.profilePhoto,
                                      ),
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              videoController
                                                  .likeVideo(snapshot.id);
                                            },
                                            child: Icon(Icons.favorite,
                                                size: 24,
                                                color:
                                                 profileController.
                                                    Colors.red
                                                // : Colors.white,
                                                ),
                                          ),
                                          const SizedBox(height: 7),
                                          Text(
                                            snapshot.like.toString(),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap: () => Get.to(() =>
                                                CommentScreen(id: snapshot.id)),
                                            child: const Icon(
                                              Icons.comment,
                                              size: 24,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 7),
                                          Text(
                                            snapshot.commentCount.toString(),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: const Icon(
                                              Icons.reply,
                                              size: 40,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 7),
                                          Text(
                                            snapshot.shareCount.toString(),
                                          )
                                        ],
                                      ),
                                      CustomCircleAnimation(
                                        child: buildMusicAlbum(
                                            snapshot.profilePhoto),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
      }),
    );
  }

  buildProfile(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(children: [
        Positioned(
          left: 5,
          child: Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image(
                image: NetworkImage(profilePhoto),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
      ]),
    );
  }

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(11),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.grey,
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(profilePhoto),
                  fit: BoxFit.cover,
                ),
              ))
        ],
      ),
    );
  }
}
