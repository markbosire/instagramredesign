import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_redesign/models/user_model.dart';

import '../models/post_model.dart';

class PostRepository extends GetxController {
  static PostRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  createPost(PostModel post) async {
    await _db
        .collection("Posts")
        .add(post.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "You post has been created.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),
        )
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
  }

  Future<PostModel> getPostDetails(String email) async {
    final snapshot =
        await _db.collection("Posts").where("Email", isEqualTo: email).get();

    final postData = snapshot.docs.map((e) => PostModel.fromSnapshot(e)).single;
    print(postData);

    return postData;
  }
}
