import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  String userName;
  String uid;
  String id;
  int like;
  int commentCount;
  int shareCount;
  String songName;
  String caption;
  String videoUrl;
  String thumbnail;
  String profilePhoto;
  VideoModel({
    required this.userName,
    required this.uid,
    required this.id,
    required this.like,
    required this.commentCount,
    required this.shareCount,
    required this.songName,
    required this.caption,
    required this.videoUrl,
    required this.thumbnail,
    required this.profilePhoto,
  });
 

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'userName': userName});
    result.addAll({'uid': uid});
    result.addAll({'id': id});
    result.addAll({'like': like});
    result.addAll({'commentCount': commentCount});
    result.addAll({'shareCount': shareCount});
    result.addAll({'songName': songName});
    result.addAll({'caption': caption});
    result.addAll({'videoUrl': videoUrl});
    result.addAll({'thumbnail': thumbnail});
    result.addAll({'profilePhoto': profilePhoto});
  
    return result;
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      userName: map['userName'] ?? '',
      uid: map['uid'] ?? '',
      id: map['id'] ?? '',
      like: map['like']?.toInt() ?? 0,
      commentCount: map['commentCount']?.toInt() ?? 0,
      shareCount: map['shareCount']?.toInt() ?? 0,
      songName: map['songName'] ?? '',
      caption: map['caption'] ?? '',
      videoUrl: map['videoUrl'] ?? '',
      thumbnail: map['thumbnail'] ?? '',
      profilePhoto: map['profilePhoto'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoModel.fromJson(String source) => VideoModel.fromMap(json.decode(source));
}
