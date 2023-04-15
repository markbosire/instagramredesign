import 'package:get/get.dart';
import 'package:instagram_redesign/controllers/auth_controller.dart';
import 'package:instagram_redesign/repositories/user_repository.dart';

class ProfileController extends GetxController {
  static ProfileController authInstance = Get.find();
  final _authController = Get.put(AuthController());
  final _userRepo = Get.put(UserRepository());
  getUserData() {
    final email = _authController.firebaseUser.value?.email;
    if (email != null) {
      return _userRepo.getUserDetails(email);
      print('working');
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }
}
