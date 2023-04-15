import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:instagram_redesign/controllers/auth_controller.dart';
import 'package:instagram_redesign/models/user_model.dart';
import 'package:instagram_redesign/repositories/user_repository.dart';

class SignUpStepsController extends GetxController {
  static SignUpStepsController get instance => Get.find();
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();

  final color = Colors.grey.obs;
  final isEmailTaken = false.obs;
  final isUserNameTaken = false.obs;
  Rx<File?> image = Rx<File?>(null);

  final picker = ImagePicker();

  Future<bool> fetchEmails(email) async {
    QuerySnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where("Email", isEqualTo: email)
        .get();

    isEmailTaken.value = userSnapshot.docs.isNotEmpty ? true : false;
    return isEmailTaken.value;
  }

  Future<bool> fetchUserName(username) async {
    QuerySnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where("userName", isEqualTo: username)
        .get();

    isUserNameTaken.value = userSnapshot.docs.isNotEmpty ? true : false;
    return isUserNameTaken.value;
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  Future uploadImage() async {
    final _authController = Get.put(AuthController());
    final email = _authController.firebaseUser.value?.email;
    if (image.value != null) {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      await ref.putFile(image.value!);

      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    }
  }

  final userRepo = Get.put(UserRepository());
  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
  }
}
