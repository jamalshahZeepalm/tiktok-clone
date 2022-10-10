import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String userName;
  String bio;
  String email;
  String uid;
  String profileImage;
  UserModel({
    required this.userName,
    required this.bio,
    required this.email,
    required this.uid,
    required this.profileImage,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userName': userName});
    result.addAll({'bio': bio});
    result.addAll({'email': email});
    result.addAll({'uid': uid});
    result.addAll({'profileImage': profileImage});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userName: map['userName'] ?? '',
      bio: map['bio'] ?? '',
      email: map['email'] ?? '',
      uid: map['uid'] ?? '',
      profileImage: map['profileImage'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  static UserModel fromSnap(DocumentSnapshot documentSnapshot) {
    var snapshot = (documentSnapshot.data()! as Map<String, dynamic>);
    return UserModel(
      userName: snapshot['userName'],
      bio: snapshot['bio'],
      profileImage: snapshot['profileImage'],
      email: snapshot['email'],
      uid: snapshot['uid'],
    );
  }
}
