import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:instagram_redesign/configurations/auth_state.dart';
import 'package:instagram_redesign/configurations/colors.dart';
import 'package:instagram_redesign/controllers/auth_controller.dart';
import 'package:instagram_redesign/controllers/obscure_controller.dart';
import 'package:instagram_redesign/controllers/signupsteps_controller.dart';
import 'package:instagram_redesign/models/user_model.dart';
import 'package:instagram_redesign/views/components/mycustomwidgets.dart';
import 'package:instagram_redesign/views/screens/sign_in.dart';

class SignUpSteps extends StatelessWidget {
  final RxInt page = 1.obs;
  final AuthController _authController = Get.find();
  @override
  Widget build(BuildContext context) {
    final SignUpStepsController controller = Get.put(SignUpStepsController());
    var screenSizeWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
            body: Container(
      width: screenSizeWidth,
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Obx(
            () => Container(
              child: page.value == 1
                  ? Children1(page: page)
                  : page.value == 2
                      ? Children2(
                          page: page,
                        )
                      : Children3(page: page),
            ),
          ),
          registrationButton("NEXT", () async {
            if (page.value == 1) {
              if (await SignUpStepsController.instance
                  .fetchEmails(controller.email.text)) {
                Get.snackbar("Alert", "Email exists",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.redAccent.withOpacity(0.5),
                    colorText: Colors.white);
                Get.to(SignIn(), arguments: controller.email.text);
              } else {
                page.value = 2;
              }
            } else if (page.value == 2) {
              if (await SignUpStepsController.instance
                  .fetchUserName(controller.userName.text)) {
                Get.snackbar("Alert", "UserName exists",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.redAccent.withOpacity(0.5),
                    colorText: Colors.white);
              } else {
                page.value = 3;
              }
            } else {
              await _authController.registerWithEmailAndPassword(
                controller.email.text.trim().toLowerCase(),
                controller.password.text.trim(),
              );

              final user = UserModel(
                  email: controller.email.text.trim().toLowerCase(),
                  userName: controller.userName.text.trim(),
                  fullName:
                      ("${controller.firstName.text} ${controller.lastName.text}"),
                  profileUrl: await controller.uploadImage());
              if (await checkAuthState()) {
                Get.lazyPut(() => SignUpStepsController());
                SignUpStepsController.instance.createUser(user);
              }
            }
          }, mainColour,
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
              radius: 0.0,
              height: 40.0)
        ]),
      ),
    )));
  }
}

class Children1 extends StatelessWidget {
  final RxInt page;
  const Children1({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignUpStepsController controller = Get.find<SignUpStepsController>();
    var screenSizeWidth = MediaQuery.of(context).size.width;

    return Column(children: [
      const SizedBox(
        height: 40.0,
      ),
      logoImageAsset("logo.png", scale: 0.5),
      const SizedBox(
        height: 40.0,
      ),
      progressIndicator(Colors.grey, screenSizeWidth, active: page),
      const SizedBox(
        height: 40.0,
      ),
      mytextField(
        "Email",
        Icons.email,
        controller: controller.email,
      ),
      const SizedBox(
        height: 40.0,
      ),
    ]);
  }
}

class Children2 extends StatelessWidget {
  final RxInt page;

  const Children2({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignUpStepsController controller = Get.find<SignUpStepsController>();
    var screenSizeWidth = MediaQuery.of(context).size.width;

    return Column(children: [
      const SizedBox(
        height: 40.0,
      ),
      logoImageAsset("logo.png", scale: 0.5),
      const SizedBox(
        height: 40.0,
      ),
      progressIndicator(Colors.grey, screenSizeWidth, active: page),
      const SizedBox(
        height: 40.0,
      ),
      mytextField(
        "First Name",
        Icons.person_2,
        controller: controller.firstName,
      ),
      const SizedBox(
        height: 20.0,
      ),
      mytextField(
        "Last Name",
        Icons.person_2_outlined,
        controller: controller.lastName,
      ),
      const SizedBox(
        height: 20.0,
      ),
      mytextField(
        "UserName",
        Icons.person_4_outlined,
        controller: controller.userName,
      ),
      const SizedBox(
        height: 20.0,
      ),
    ]);
  }
}

class Children3 extends StatelessWidget {
  final RxInt page;

  const Children3({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ObscureController c = Get.put(ObscureController());
    final SignUpStepsController controller = Get.find<SignUpStepsController>();
    var screenSizeWidth = MediaQuery.of(context).size.width;
    return Column(children: [
      const SizedBox(
        height: 40.0,
      ),
      logoImageAsset("logo.png", scale: 0.5),
      const SizedBox(
        height: 40.0,
      ),
      progressIndicator(Colors.grey, screenSizeWidth, active: page),
      const SizedBox(
        height: 40.0,
      ),
      myText("Pick Profile Picture", size: 16.0, weight: FontWeight.w700),
      const SizedBox(
        height: 20.0,
      ),
      Obx(() => userProfile(controller.image.value)),
      const SizedBox(
        height: 20.0,
      ),
      registrationButton("Pick Image", () {
        controller.getImage();
      }, storyColour, width: 160.0, height: 40.0, radius: 0.0),
      const SizedBox(
        height: 20.0,
      ),
      Obx(() => mypasswordField(
          controller: controller.password,
          "Password",
          obscure: c.obscureText.value,
          toggleObscureText: c.toggleObscureText,
          Icons.lock_outline_rounded)),
      const SizedBox(
        height: 20.0,
      ),
    ]);
  }
}
