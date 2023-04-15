import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_redesign/models/post_model.dart';
import 'package:instagram_redesign/repositories/post_repository.dart';

class ImagepickerController extends GetxController {
  var imageUrl = "".obs;
  final postRepo = Get.put(PostRepository());
  static ImagepickerController get instance => Get.find();
  Future<void> postImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    print('${file?.path}');
    if (file == null) return;
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
    try {
      await referenceImageToUpload.putFile(File(file.path));
      imageUrl.value = await referenceImageToUpload.getDownloadURL();
      print(imageUrl.value);
    } catch (e) {
      print("the error id ${e}");
    }
  }

  Future<void> createPost(PostModel post) async {
    await postRepo.createPost(post);
  }
}
