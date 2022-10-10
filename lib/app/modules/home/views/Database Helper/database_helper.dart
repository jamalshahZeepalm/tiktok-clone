import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DataBaseHelper {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;

  CollectionReference get userCollection => firestore.collection("Users");
  CollectionReference get videosCollection => firestore.collection("Videos");
  CollectionReference followingCollection(String uid) =>
      userCollection.doc(uid).collection("Following");
  CollectionReference followersCollection(String uid) =>
      userCollection.doc(uid).collection("Followers");

  CollectionReference likesCollection(String uid) =>
      userCollection.doc(uid).collection("Likes");
}
