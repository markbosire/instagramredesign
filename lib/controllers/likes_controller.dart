import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/Likes_model.dart';
import 'package:flutter/material.dart';

class LikesController extends GetxController {
  final _url = 'https://flutterapi-nine.vercel.app/likes';

  final likes = <Likes>[].obs;
  final colour = Colors.white.obs;
  final likescount = 0.obs;

  @override
  void onInit() {
    fetchLikes();
    super.onInit();
  }

  Future<void> fetchLikes() async {
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      final likesList = json.decode(response.body) as List<dynamic>;
      likes.assignAll(likesList.map((json) => Likes.fromJson(json)).toList());
    } else {
      throw Exception('Failed to load likes');
    }
  }

  Future<void> addLike(String postId, String email) async {
    final response = await http.post(Uri.parse(_url),
        body: {'post_id': postId.toString(), 'email': email});
    if (response.statusCode == 201 || response.statusCode == 200) {
      final newLikeId = json.decode(response.body)['insertId'];
      likes.add(Likes(id: newLikeId, postId: postId.toString(), email: email));
      Get.snackbar(
        'Like added',
        'The like was added successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else if (response.statusCode == 400) {
      Get.snackbar(
        'Validation error',
        'Please provide a valid post ID and email address',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      throw Exception('Failed to add like');
    }
  }

  Future<void> deleteLike(int likeId) async {
    final response = await http.delete(Uri.parse('$_url/$likeId'));
    if (response.statusCode == 200) {
      likes.removeWhere((like) => like.id == likeId);
      Get.snackbar(
        'Like deleted',
        'The like was deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      throw Exception('Failed to delete like');
    }
  }
}
