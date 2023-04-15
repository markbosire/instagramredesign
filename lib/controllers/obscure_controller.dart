import 'package:get/get.dart';

class ObscureController extends GetxController {
  var obscureText = true.obs;

  void toggleObscureText() {
    obscureText.toggle();
  }
}
