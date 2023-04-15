import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_redesign/configurations/colors.dart';

import 'package:instagram_redesign/controllers/uploadimage_controller.dart';
import 'package:instagram_redesign/views/components/mycustomwidgets.dart';
import 'package:instagram_redesign/views/screens/feed.dart';
import 'package:instagram_redesign/views/screens/profile_page.dart';

class UploadPage extends StatelessWidget {
  final UploadController c = Get.put(UploadController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              children: [
                titleBar("Upload Image"),
                const SizedBox(height: 10.0),
                Obx(() => c.image.value == null
                    ? logoImageAsset("upload.png", width: 150.0, height: 150.0)
                    : Image.file(c.image.value!)),
                const SizedBox(height: 10.0),
                mytextField("Enter Description", Icons.image,
                    controller: c.descriptionController),
                const SizedBox(height: 10.0),
                registrationButton("Pick image", () {
                  c.getImage();
                }, storyColour, radius: 0.4),
                const SizedBox(height: 10.0),
                registrationButton("Upload post", () {
                  c.uploadImage();
                }, mainColour, radius: 0.4),
              ],
            ),
          ),
          bottomNavigationBar: tabBar()),
    );
  }
}
