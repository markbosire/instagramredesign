import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert';

class UnsplashController extends GetxController {
  static UnsplashController get instance => Get.find();
  var images = [].obs;

  Future<void> fetchImages() async {
    var response = await http.get(Uri.parse(
        'https://api.unsplash.com/photos?client_id=FxnhwJCsUaxPyVZVhJCqTGOtgs_YXiHq0qT4wmaaUAk'));

    if (response.statusCode == 200) {
      images.assignAll(json.decode(response.body));
    } else {
      print('Error fetching images');
    }
  }
}
