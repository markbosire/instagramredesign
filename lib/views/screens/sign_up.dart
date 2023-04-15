// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:instagram_redesign/configurations/auth_state.dart';
import 'package:instagram_redesign/configurations/colors.dart';
import 'package:instagram_redesign/controllers/auth_controller.dart';
import 'package:instagram_redesign/controllers/obscure_controller.dart';

import 'package:instagram_redesign/controllers/signup_controller.dart';
import 'package:instagram_redesign/views/components/mycustomwidgets.dart';
import 'package:instagram_redesign/models/user_model.dart';
import 'package:instagram_redesign/services/firestore_service.dart';
import 'package:instagram_redesign/views/screens/sign_in.dart';
import 'package:instagram_redesign/views/screens/welcome.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthController _authController = Get.find();
    final controller = Get.put(SignUpController());
    final ObscureController c = Get.put(ObscureController());

    /*final user = UserModel(
        email: controller.email.text.trim().toLowerCase(),
        userName: controller.userName.text.trim(),
        fullName: controller.fullName.text.trim());*/

    var screenSizeheight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        Container(
            decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                  ),
                ),
                image: DecorationImage(
                  image: AssetImage("assets/images/background_image.png"),
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter,
                  opacity: 0.5,
                ),
                color: mainColour),
            child: SingleChildScrollView(
              child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                  )),
                  child: Column(
                    children: [
                      SizedBox(height: 40.0),
                      Container(
                          height: screenSizeheight - 40.0,
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          )),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 0.01,
                                    ),
                                  )),
                              child: Column(
                                children: [
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: backButton(page: MyWidget())),
                                  SizedBox(height: 5.0),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(
                                        width: 0.01,
                                      ),
                                    )),
                                    padding: EdgeInsets.only(
                                        left: 35.0, right: 35.0),
                                    child: Column(
                                      children: [
                                        myText("Sign Up ",
                                            weight: FontWeight.w900,
                                            size: 36.0),
                                        SizedBox(height: 13.0),
                                        myText("Enter your details below",
                                            weight: FontWeight.w500,
                                            size: 16.0,
                                            colour: greyVariant),
                                        SizedBox(height: 30.0),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: myText("Username",
                                                weight: FontWeight.w500,
                                                size: 13.0)),
                                        SizedBox(height: 10.0),
                                        mytextField(
                                            "Username", Icons.person_2_outlined,
                                            controller: controller.userName),
                                        SizedBox(height: 20.0),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: myText("Full name",
                                                weight: FontWeight.w500,
                                                size: 13.0)),
                                        SizedBox(height: 10.0),
                                        mytextField(
                                            "Fullname", Icons.person_2_outlined,
                                            controller: controller.fullName),
                                        SizedBox(height: 20.0),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: myText("Email",
                                                weight: FontWeight.w500,
                                                size: 13.0)),
                                        SizedBox(height: 10.0),
                                        mytextField(
                                            "Email", Icons.email_outlined,
                                            controller: controller.email),
                                        SizedBox(height: 20.0),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: myText("Password",
                                                weight: FontWeight.w500,
                                                size: 13.0)),
                                        SizedBox(height: 10.0),
                                        Obx(() => mypasswordField(
                                            controller: controller.password,
                                            "Password",
                                            obscure: c.obscureText.value,
                                            toggleObscureText:
                                                c.toggleObscureText,
                                            Icons.lock_outline_rounded)),
                                        SizedBox(height: 20.0),
                                        registrationButton("Sign Up", () async {
                                          await _authController
                                              .registerWithEmailAndPassword(
                                            controller.email.text
                                                .trim()
                                                .toLowerCase(),
                                            controller.password.text.trim(),
                                          );
                                          /* if (await checkAuthState()) {
                                            SignUpController.instance
                                                .createUser(user);
                                          }*/
                                        }, buttonColor),
                                        Container(
                                            margin: EdgeInsets.only(top: 35.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                myText(
                                                  "Already a member?",
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      Get.offAll(SignIn());
                                                    },
                                                    child: myText(" Sign in",
                                                        colour:
                                                            primaryTextColor))
                                              ],
                                            )),
                                        SizedBox(height: 20.0),
                                        logoImageAsset("logo.png",
                                            height: 40.0, width: 40.0),
                                        SizedBox(height: 13.4),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ],
                  )),
            )),
      ],
    )));
  }
}

void btnClicked() {
  print('buttonclicked');
}
