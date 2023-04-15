import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:instagram_redesign/controllers/userPostsController.dart';
import 'package:instagram_redesign/views/components/mycustomwidgets.dart';

class UserPosts extends StatelessWidget {
  final UserPostsController c = Get.put(UserPostsController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: c.imageUrls.value.length,
          itemBuilder: (context, index) =>
              explorePost(c.imageUrls.value[index]),
        ));
  }
}
