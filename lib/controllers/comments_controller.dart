import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert';

import 'package:instagram_redesign/models/sqlpost_model.dart';
import 'package:instagram_redesign/repositories/comments_repository.dart';

class CommentsController extends GetxController {
  static CommentsController get instance => Get.find();
  Future<List<SQLPost>> fetchPosts() async {
    final response = await http
        .get(Uri.parse('https://igredesign.babanovachrono.repl.co/posts'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((post) => SQLPost.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<void> sendPost({required String postid, required String email}) async {
    try {
      final response = await http.post(
        Uri.parse('https://igredesign.babanovachrono.repl.co/posts'),
        body: jsonEncode({
          'postid': postid,
          'email': email,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Post created successfully');
      } else {
        Get.snackbar('Error', response.body);
        print(response.body);
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', e.toString());
    }
  }

  final CommentsRepository _commentsRepository = CommentsRepository();
  final commentTextController = TextEditingController();

  Future<void> sendComment(String postId) async {
    try {
      int commentId = await _commentsRepository.sendComment(
        postId,
        commentTextController.text,
        DateTime.now(),
      );
      Get.snackbar('Success', 'Comment sent with ID: $commentId');
      commentTextController.clear();
    } catch (e) {
      Get.snackbar('Error', 'Failed to send comment: $e');
    }
  }
}
