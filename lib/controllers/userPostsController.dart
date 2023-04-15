import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_redesign/controllers/auth_controller.dart';

class UserPostsController extends GetxController {
  Rx<List<String>> imageUrls = Rx<List<String>>([]);

  @override
  void onInit() {
    super.onInit();
    fetchUserPosts();
  }

  Future<void> fetchUserPosts() async {
    final _authController = Get.put(AuthController());
    final email = _authController.firebaseUser.value?.email;
    List<String> urls = [];

    QuerySnapshot postSnapshot = await FirebaseFirestore.instance
        .collection('posts')
        .where('email', isEqualTo: email)
        .get();

    for (var post in postSnapshot.docs) {
      urls.add(post['imageUrl']);
    }

    imageUrls.value = urls;
  }
}
