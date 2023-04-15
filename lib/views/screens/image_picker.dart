import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_redesign/controllers/auth_controller.dart';
import 'package:instagram_redesign/controllers/image_picker_controller.dart';
import 'package:instagram_redesign/models/post_model.dart';

class Imagepicker extends StatelessWidget {
  final ImagepickerController controller = Get.put(ImagepickerController());
  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    final _authController = Get.put(AuthController());
    final email = _authController.firebaseUser.value?.email;
    int currentTimeMillis = DateTime.now().millisecondsSinceEpoch;

    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => Center(
            child: Column(
              children: [
                Container(
                  height: 305,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage(controller.imageUrl.value),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  )),
                ),
                IconButton(
                    onPressed: () async {
                      ImagepickerController.instance.postImage();
                      final post = PostModel(
                          email: email!,
                          userName: "pablo",
                          imageUrl: controller.imageUrl.value,
                          timestamp: currentTimeMillis.toString());

                      print("the url is ${post}");
                      ImagepickerController.instance.createPost(post);
                    },
                    icon: const Icon(Icons.camera_alt)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
