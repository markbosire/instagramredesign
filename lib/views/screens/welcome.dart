// ignore_for_file: unused_import, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:instagram_redesign/configurations/colors.dart';
import 'package:instagram_redesign/views/components/mycustomwidgets.dart';
import 'package:instagram_redesign/views/screens/sign_in.dart';
import 'package:instagram_redesign/views/screens/sign_up.dart';
import 'package:instagram_redesign/views/screens/signupsteps.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
  void getmode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkModeEnabled = prefs.getBool('isDarkModeEnabled') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    var screenSizeHeight = MediaQuery.of(context).size.height;
    var screenSizeWidth = MediaQuery.of(context).size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
            child: Scaffold(
                body: SizedBox(
                    height: screenSizeHeight,
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        Container(
                          height: screenSizeHeight,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/background_image.png"),
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              ),
                              color: Colors.red),
                          child: SizedBox(
                              height: screenSizeHeight,
                              child: ListView(
                                children: [
                                  SizedBox(
                                      height: screenSizeHeight * 0.478 - 24.0),
                                  SizedBox(
                                    height: screenSizeHeight -
                                        screenSizeHeight * 0.478,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.0),
                                        topRight: Radius.circular(20.0),
                                      ),
                                      child: Container(
                                        color: Colors.white,
                                        padding: EdgeInsets.only(
                                            left: 35.0, right: 35.0),
                                        child: SizedBox(
                                            height: screenSizeHeight -
                                                screenSizeHeight * 0.478,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                    height: screenSizeHeight *
                                                        0.0616),
                                                registrationButton(
                                                    "Sign in with Facebook",
                                                    () {},
                                                    facebookColor,
                                                    link: "facebook.png"),
                                                SizedBox(
                                                    height: screenSizeHeight *
                                                        0.0246),
                                                registrationButton(
                                                    "Sign in with your Email",
                                                    () {
                                                  Get.offAll(SignIn());
                                                }, buttonColor),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        top: screenSizeHeight *
                                                                0.075 -
                                                            24.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        myText(
                                                          "Not a member?",
                                                        ),
                                                        GestureDetector(
                                                            onTap: () {
                                                              Get.offAll(
                                                                  SignUpSteps());
                                                            },
                                                            child: myText(
                                                                " Signup now",
                                                                colour:
                                                                    primaryTextColor))
                                                      ],
                                                    )),
                                                SizedBox(
                                                    height: screenSizeHeight *
                                                        0.034),
                                                logoImageAsset("logo.png",
                                                    height: 40.0, width: 40.0),
                                              ],
                                            )),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ],
                    ))))));
  }
}
