// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:instagram_redesign/controllers/auth_controller.dart';
import 'package:instagram_redesign/controllers/comment_controller.dart';
import 'package:instagram_redesign/controllers/posts_controller.dart';
import 'package:instagram_redesign/models/comment_model.dart';
import 'package:instagram_redesign/views/components/mycustomwidgets.dart';
import 'package:instagram_redesign/views/screens/feed.dart';
import 'package:instagram_redesign/configurations/colors.dart';
import 'package:flutter/cupertino.dart';

class CommentsPage extends StatelessWidget {
  final String argument;
  final _authController = Get.put(AuthController());
  final CommentController commentController = Get.put(CommentController());
  final PostsController postsController = Get.put(PostsController());

  CommentsPage({required this.argument});

  String formatTime(String timeInMs) {
    print(timeInMs);
    int time = DateTime.now().millisecondsSinceEpoch - int.parse(timeInMs);
    int seconds = (time / 1000).floor();
    int minutes = (seconds / 60).floor();
    int hours = (minutes / 60).floor();
    int days = (hours / 24).floor();
    int weeks = (days / 7).floor();

    if (weeks > 0) {
      return '$weeks w ago';
    } else if (days > 0) {
      return '$days d ago';
    } else if (hours > 0) {
      return '$hours h ago';
    } else if (minutes > 0) {
      return '$minutes m ago';
    } else {
      return '$seconds s ago';
    }
  }

  Future<String> commenturl(email) async {
    CommentUser _commentUser = await commentUsername(email);
    return _commentUser.profileUrl;
  }

  Future<String> thecommentuser(email) async {
    CommentUser _commentUser = await commentUsername(email);
    return _commentUser.username;
  }

  Future<Map<Future<String>, Future<String>>> thecomment(
      profileurl, username) async {
    return {
      Future.value("url"): Future.value(profileurl),
      Future.value("username"): Future.value(username)
    };
  }

  bool _showAppBar() {
    return commentController.comments.any((comment) => comment.isSelected);
  }

  void _deselectAllComments() {
    commentController.comments.forEach((comment) => comment.isSelected = false);
    commentController.update();
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(
          Icons.close,
          color: Colors.black,
        ),
        onPressed: () {
          _deselectAllComments();
          commentController.showAppbar.value = false;
        },
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () {
            commentController.deleteSelectedComments();
            _deselectAllComments();
            commentController.showAppbar.value = false;
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSizeheight = MediaQuery.of(context).size.height;
    postsController.getPostDetails(argument);
    final email = _authController.firebaseUser.value?.email;
    final comments =
        RxList<Comment>(commentController.commentsByPostId(argument));

    return SafeArea(
      child: Obx(
        () => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: commentController.showAppbar.value ? buildAppBar() : null,
          body: SingleChildScrollView(
            child: SizedBox(
              height: screenSizeheight - 24.0,
              child: Stack(children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(children: [
                        SizedBox(
                          width: 15.0,
                        ),
                        GestureDetector(
                            onTap: () {
                              Get.offAll(MyPage());
                            },
                            child: Icon(Icons.arrow_back)),
                        SizedBox(
                          width: 15.0,
                        ),
                        myText("Comments", size: 22.0)
                      ]),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Column(
                        children: [
                          Obx(
                            () {
                              final postDetails =
                                  postsController.postDetails.value;

                              if (postDetails.isNotEmpty) {
                                return Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.grey.shade300,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            postDetails['profileUrl']),
                                      ),
                                      title: Text(postDetails['username']),
                                      subtitle:
                                          Text(postDetails['description']),
                                    ));
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                          Obx(() {
                            final comments =
                                commentController.commentsByPostId(argument);

                            return SizedBox(
                              height: screenSizeheight - 200,
                              child: ListView.builder(
                                shrinkWrap: false,
                                itemCount: comments.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final comment =
                                      commentController.comments[index];
                                  return ListTile(
                                    onLongPress: () {
                                      if (comments[index].email == email) {
                                        commentController.toggleSelected(index);
                                        commentController.fnShowAppbar();
                                      }
                                    },
                                    tileColor: comment.isSelected
                                        ? Colors.grey[300]
                                        : null,
                                    leading: FutureBuilder<CommentUser>(
                                      future: commentUsername(
                                          comments[index].email),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<CommentUser> snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const CircularProgressIndicator();
                                        } else if (snapshot.hasData) {
                                          return CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                snapshot.data!.profileUrl),
                                          );
                                        } else {
                                          return const Icon(Icons.person);
                                        }
                                      },
                                    ),
                                    title: FutureBuilder<CommentUser>(
                                      future: commentUsername(
                                          comments[index].email),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<CommentUser> snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Text('Loading...');
                                        } else if (snapshot.hasData) {
                                          return Row(
                                            children: [
                                              myText(snapshot.data!.username,
                                                  size: 12.0,
                                                  weight: FontWeight.w700),
                                              SizedBox(
                                                width: 5.0,
                                              ),
                                              myText(
                                                  formatTime(comments[index]
                                                      .commentDate),
                                                  size: 12.0,
                                                  colour: greyVariant)
                                            ],
                                          );
                                        } else {
                                          return const Text('Unknown user');
                                        }
                                      },
                                    ),
                                    subtitle: myText(comments[index].comment,
                                        size: 16.0, weight: FontWeight.normal),
                                  );
                                },
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Colors.white,
                      child: commentTextField(commenturl(email),
                          commentController.commentTextController, () {
                        print("hh");
                        commentController.reload.value = true;
                        final comment = Comment(
                          email: email!,
                          commentDate:
                              DateTime.now().millisecondsSinceEpoch.toString(),
                          comment: commentController.commentTextController.text
                              .trim(),
                          postId: argument,
                        );
                        print(comment.comment);
                        commentController.addComment(comment);
                        comments.insert(0, comment);
                      }),
                    ),
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
