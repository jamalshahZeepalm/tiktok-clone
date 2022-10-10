import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/app/modules/Models/user_model.dart';
import 'package:tiktok_clone/app/modules/home/controllers/profile_controller.dart';
import 'package:tiktok_clone/app/modules/home/views/Database%20Helper/database_helper.dart';

class AuthController extends GetxController {
  static AuthController authController = Get.find();
  late Rx<File?> _pickedImage;
  final Rx<User?> _user = Rx<User?>(null);
  User? get getUser => _user.value;
  File? get getImage => _pickedImage.value;
  User? get user => _user.value;
  set setImage(Rx<File?> value) {
    _pickedImage = value;
  }

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(DataBaseHelper.auth.authStateChanges());
    update();
  }

// upload image
  Future<String> uploadImages({required File image}) async {
    Reference reference = DataBaseHelper.storage
        .ref()
        .child('ProfilePic')
        .child(DataBaseHelper.auth.currentUser!.uid);

    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  //image picker
  imagePick() async {
    XFile? imagePicker =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicker != null) {
      Get.snackbar('Prifile picture',
          'You have successfully selected your profile picture!');
    }
    _pickedImage = Rx<File?>(File(imagePicker!.path));
  }

  // user also store in firestore
  Future<void> addFireStore({required UserModel userModel}) async {
    DataBaseHelper.firestore
        .collection('Users')
        .doc(userModel.uid)
        .set(userModel.toMap());
  }

  //userRegister
  Future<void> registerUser(
      {required String username,
      required String bio,
      required String email,
      required String password,
      required File? image}) async {
    try {
      if (username.isNotEmpty &&
          bio.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential credential = await DataBaseHelper.auth
            .createUserWithEmailAndPassword(email: email, password: password);
        String downloadURL = await uploadImages(image: image);
        UserModel userModel = UserModel(
            userName: username,
            bio: bio,
            email: email,
            uid: credential.user!.uid,
            profileImage: downloadURL);
        await addFireStore(userModel: userModel);
        Get.back(); //ab kro yea masla aata hai..?
        Get.snackbar(
          'Account Creation',
          'Successfully Account Created',
        );
      } else {
        Get.snackbar(
          'Error Account Creating',
          'Please enter all the fields',
        );
      }
    } catch (error) {
      Get.snackbar(
        'Error Account Creating',
        error.toString(),
      );
    }
  }

  Future<void> loginUser(
      {required String email, required String password}) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await DataBaseHelper.auth
            .signInWithEmailAndPassword(email: email, password: password);
        Get.snackbar(
          'Account Signing',
          'successfully Signin..',
        );
      } else {
        Get.snackbar(
          'Error Logging in',
          'Please enter all the fields',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error Logging in',
        e.toString(),
      );
    }
  }

  logoutUser() async {
    await DataBaseHelper.auth.signOut();
    if (Get.isRegistered<ProfileController>()) {
      Get.delete<ProfileController>();
    }
  }
}
