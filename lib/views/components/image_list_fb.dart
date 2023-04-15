import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_redesign/controllers/comment_controller.dart';
import 'package:instagram_redesign/controllers/likes_controller.dart';
import 'package:instagram_redesign/controllers/posts_controller.dart';
import 'package:instagram_redesign/controllers/auth_controller.dart';
import 'package:instagram_redesign/views/components/mycustomwidgets.dart';
import 'package:instagram_redesign/views/screens/comments_page.dart';
import '/models/Likes_model.dart';

class PostsPage extends StatelessWidget {
  final PostsController c = Get.put(PostsController());
  final LikesController l = Get.put(LikesController());

  final _authController = Get.put(AuthController());
  final CommentController commentController = Get.put(CommentController());
  @override
  Widget build(BuildContext context) {
    final email = _authController.firebaseUser.value?.email;
    final likesController = Get.find<LikesController>();

    return Obx(() {
      return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: c.posts.value.length,
          itemBuilder: (context, index) => post(
              c.posts.value[index]['profileUrl'],
              c.posts.value[index]['username'],
              "America",
              c.posts.value[index]['imageUrl'],
              () {
                Get.offAll(
                    CommentsPage(argument: c.posts.value[index]["postId"]));
              },
              () {
                if (email == c.posts.value[index]['email']) {
                  c.showDeleteConfirmationPopUp(c.posts.value[index]["postId"]);
                }
              },
              c.posts.value[index]["commentnum"],
              c.posts.value[index]["likeColour"],
              c.posts.value[index]["likeCount"],
              () {
                if (c.filterLikes(c.posts.value[index]["postId"])) {
                  c.deleteLike(c.getLikeId(c.posts.value[index]["postId"])!);
                } else {
                  c.addLike(c.posts.value[index]["postId"]);
                }
              }));
    });
  }
}
