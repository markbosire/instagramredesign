import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_redesign/configurations/firebase_constants.dart';
import 'package:instagram_redesign/views/screens/feed.dart';
import 'package:instagram_redesign/views/screens/image_picker.dart';
import 'package:instagram_redesign/views/screens/profile_page.dart';
import 'package:instagram_redesign/views/screens/uploadimage.dart';
import 'package:instagram_redesign/views/screens/welcome.dart';

class AuthController extends GetxController {
  static AuthController authInstance = Get.find();
  late Rx<User?> firebaseUser;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());

    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user != null) {
      // user is logged in
      Get.offAll(() => MyPage());
    } else {
      // user is null as in user is not available or not logged in
      Get.offAll(() => MyWidget());
    }
  }

  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Error', 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        Get.snackbar('Error', 'The email is invalid.');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      print("$email 1");

      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      print("$email 2");

      firebaseUser.value = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Error', 'Wrong password provided for that user.');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      print("rtyu");
    }
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
      firebaseUser.value = null;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
