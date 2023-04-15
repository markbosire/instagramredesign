import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_redesign/controllers/comment_controller.dart';
import 'package:instagram_redesign/controllers/auth_controller.dart';

import '../models/comment_model.dart';
import '../models/Likes_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostsController extends GetxController {
  Rx<List<Map<String, dynamic>>> posts = Rx<List<Map<String, dynamic>>>([]);
  String? username;

  String? profileUrl;

  final CommentController commentController = Get.put(CommentController());
  final String baseUrl = 'https://flutterapi-nine.vercel.app';

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
    fetchLikes();
  }

  final _url = 'https://flutterapi-nine.vercel.app/likes';

  final likes = <Likes>[].obs;
  var comments = <Comment>[].obs;
  int? commentsnum;
  var postDetails = {}.obs;
  var lcolour = Colors.white.obs;
  var count = 0.obs;

  Future<void> fetchLikes() async {
    final response = await http.get(Uri.parse(_url), headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      final likesList = json.decode(response.body) as List<dynamic>;
      likes.assignAll(likesList.map((json) => Likes.fromJson(json)).toList());
    } else {
      throw Exception('Failed to load likes');
    }
  }

  bool filterLikes(postId) {
    final authController = Get.put(AuthController());

    final email = authController.firebaseUser.value?.email;

    bool result = false;
    for (Likes like in likes) {
      if (like.postId == postId && like.email == email) {
        result = true;
        break;
      }
    }
    return result;
  }

  int? getLikeId(String postId) {
    final authController = Get.put(AuthController());

    final email = authController.firebaseUser.value?.email;

    int? result;
    for (Likes like in likes) {
      if (like.postId == postId && like.email == email) {
        result = like.id!;
        break;
      }
    }
    return result;
  }

  Future<void> addLike(String postId) async {
    final authController = Get.put(AuthController());

    final email = authController.firebaseUser.value?.email;
    print("$postId $email");

    try {
      final response = await http.post(Uri.parse(_url),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'post_id': postId, 'email': email}));
      if (response.statusCode == 201 || response.statusCode == 200) {
        final newLikeId = json.decode(response.body)['insertId'];
        likes.add(
            Likes(id: newLikeId, postId: postId.toString(), email: email!));
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
        print("${response.statusCode} ${response.body}");
      }
    } catch (e) {
      print('Exception occurred: $e');
      throw e;
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

  Future<void> fetchPosts() async {
    List<Map<String, dynamic>> postList = [];

    QuerySnapshot postSnapshot =
        await FirebaseFirestore.instance.collection('posts').get();

    for (var post in postSnapshot.docs) {
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where("Email", isEqualTo: post['email'])
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        // At least one document exists
        DocumentSnapshot firstUserDoc = userSnapshot.docs.first;
        username = firstUserDoc['userName'];
        profileUrl = firstUserDoc['profileUrl'];
      } else {
        // No documents exist
        print('No user documents with email ${post['email']} exist');
      }
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
        comments.value = comments
            .where((comment) => comment.postId == post["postId"])
            .toList();
        commentsnum = comments.length;
      } else {
        print(response.body);
      }
      filterLikes(post["postId"])
          ? lcolour.value = Colors.red
          : lcolour.value = Colors.white;
      count.value = likes.where((like) => like.postId == post["postId"]).length;
      postList.add({
        'imageUrl': post['imageUrl'],
        'description': post['description'],
        'username': username,
        'email': post["email"],
        'postId': post['postId'],
        'profileUrl': profileUrl,
        'commentnum': commentsnum,
        'likeColour': lcolour.value,
        'likeCount': "${count.value}",
      });
    }

    posts.value = postList;
  }

  Future<Map> getPostDetails(String postId) async {
    QuerySnapshot postSnapshot = await FirebaseFirestore.instance
        .collection('posts')
        .where('postId', isEqualTo: postId)
        .get();

    if (postSnapshot.docs.isNotEmpty) {
      // At least one document exists
      DocumentSnapshot postDoc = postSnapshot.docs.first;
      String email = postDoc['email'];

      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('Email', isEqualTo: email)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        // At least one document exists
        DocumentSnapshot firstUserDoc = userSnapshot.docs.first;
        String username = firstUserDoc['userName'];
        String profileUrl = firstUserDoc['profileUrl'];
        String description = postDoc['description'];

        postDetails.value = {
          'username': username,
          'description': description,
          'profileUrl': profileUrl,
        };
      } else {
        // No documents exist
        print('No user documents with email $email exist');
      }
    } else {
      // No documents exist
      print('No post documents with postId $postId exist');
    }

    return postDetails.value;
  }

  var isPopUpVisible = false.obs;

  void showDeleteConfirmationPopUp(postId) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(10.0),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Are you sure you want to delete this post?'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text('CANCEL'),
                ),
                TextButton(
                  onPressed: () {
                    // Delete post from Firebase

                    FirebaseFirestore.instance
                        .collection('posts')
                        .where('postId', isEqualTo: postId)
                        .get()
                        .then((querySnapshot) {
                      querySnapshot.docs.forEach((doc) {
                        doc.reference
                            .delete()
                            .then((_) =>
                                Get.snackbar('', 'Post  deleted successfully.'))
                            .catchError((error) => print(
                                'Failed to delete post ${doc.id}: $error'));
                      });
                    }).catchError((error) =>
                            print('Failed to get posts by author: $error'));

                    // Hide the pop-up
                    isPopUpVisible.value = false;
                    Get.back();
                  },
                  child: Text('DELETE'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void deletePost() {
    // Delete post from Firebase
  }
}
