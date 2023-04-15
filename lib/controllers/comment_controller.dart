import 'dart:convert';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import '../models/comment_model.dart';
import 'package:flutter/material.dart';

class CommentController extends GetxController {
  @override
  void onInit() {
    fetchComment();
    super.onInit();
  }

  var comments = <Comment>[].obs;
  var reload = false.obs;
  var showAppbar = false.obs;
  final commentTextController = TextEditingController();

  void fnShowAppbar() {
    showAppbar.value = true;
  }

  final String baseUrl = 'https://flutterapi-nine.vercel.app';
  Future<void> deleteComment(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/comments/$id'));
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.snackbar('Success', 'Comment deleted successfully');
    } else {
      Get.snackbar('Error', 'Error deleting comment');
    }
  }

  // Other code
  Future<void> deleteSelectedComments() async {
    final selectedComments =
        comments.where((comment) => comment.isSelected).toList();
    for (var comment in selectedComments) {
      // Call the API to delete the comment
      final response = await http
          .delete(Uri.parse('$baseUrl/comments/${comment.comment_id}'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Success', 'Comment deleted successfully');
      } else {
        Get.snackbar('Error', 'Error deleting comment');
      }
      // Remove the comment from the local list
      comments.remove(comment);
    }
    update();
  }

  void toggleSelected(int index) {
    comments[index].isSelected = !comments[index].isSelected;
    update();
  }

  Future<void> updateComment(int id, String comment) async {
    final response = await http
        .put(Uri.parse('$baseUrl/comments/$id'), body: {'comment': comment});
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.snackbar('Success', 'Comment updated successfully');
    } else {
      Get.snackbar('Error', 'Error updating comment');
    }
  }

  Future<void> addComment(Comment comment) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/comments'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(comment.toJson()),
      );

      if (response.statusCode == 201) {
        Get.snackbar('Success', comment.toJson().toString());
      } else {
        Get.snackbar('Error', response.body);
        print(response.body);
      }
    } catch (e) {
      print("the error is $e");
      Get.snackbar('Error', e.toString());
    }
  }

  void fetchComment() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/comments'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        comments.value =
            List<Comment>.from(jsonData.map((x) => Comment.fromJson(x)));
      } else {
        print(response.body);
      }
    } catch (e) {
      print("errorsays$e");
      Get.snackbar('Error', e.toString());
    }
  }

  List<Comment> commentsByPostId(String postId) {
    return comments.where((comment) => comment.postId == postId).toList();
  }

  int commentQuantity(String postId) {
    var cm = comments.where((comment) => comment.postId == postId).toList();
    print(cm.length);
    return cm.length;
  }
}

class CommentUser {
  final String username;
  final String profileUrl;

  CommentUser(this.username, this.profileUrl);
}

Future<CommentUser> commentUsername(email) async {
  var username;
  var profileUrl;
  var time;
  var description;
  try {
    QuerySnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where("Email", isEqualTo: email)
        .get();

    if (userSnapshot.docs.isNotEmpty) {
      // At least one document exists
      DocumentSnapshot firstUserDoc = userSnapshot.docs.first;
      username = firstUserDoc['userName'];
      profileUrl = firstUserDoc['profileUrl'];
      time = firstUserDoc['timestamp'];
      profileUrl = firstUserDoc['profileUrl'];
    } else {
      // No documents exist
      print('No user documents with email exist');
    }
  } catch (e) {
    print("error $e");
  }

  return (CommentUser(username, profileUrl));
}
