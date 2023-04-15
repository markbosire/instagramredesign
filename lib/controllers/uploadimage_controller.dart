import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_redesign/controllers/auth_controller.dart';
import 'package:instagram_redesign/controllers/comments_controller.dart';

class UploadController extends GetxController {
  final commentsController = Get.put(CommentsController());
  Rx<File?> image = Rx<File?>(null);

  TextEditingController descriptionController = TextEditingController();
  final picker = ImagePicker();

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
      final String time = DateTime.now().millisecondsSinceEpoch.toString();
      FirebaseFirestore.instance.collection('posts').add({
        'email': email,
        'description': descriptionController.text,
        'imageUrl': downloadURL,
        'postId': time,
      }).whenComplete(() {
        Get.snackbar("Success", "You postt has been created.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.5),
            colorText: Colors.white);
      }).catchError((error, stackTrace) {
        Get.snackbar("Error", "Something went wrong. Try again",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.5),
            colorText: Colors.white);
        print(error.toString());
      });
    }
  }
}
