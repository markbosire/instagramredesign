// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_redesign/configurations/colors.dart';
import 'package:instagram_redesign/controllers/auth_controller.dart';
import 'package:instagram_redesign/controllers/profile_controller.dart';
import 'package:instagram_redesign/models/user_model.dart';
import 'package:instagram_redesign/views/components/mycustomwidgets.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:instagram_redesign/views/components/userposts.dart';
import 'package:instagram_redesign/views/screens/editprofile.dart';
import 'package:instagram_redesign/views/screens/uploadimage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    void clicked() {
      print("clicked");
    }

    var screenSizeheight = MediaQuery.of(context).size.height;
    var screenSizeWidth = MediaQuery.of(context).size.width;
    final controller = Get.put(ProfileController());
    return Scaffold(
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: SizedBox(
              height: screenSizeheight,
              width: screenSizeWidth,
              child: ListView(
                children: [
                  Stack(
                    children: [
                      Container(
                          height: screenSizeheight,
                          width: screenSizeWidth,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/mortality.jpeg"),
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                              opacity: 0.5,
                            ),
                          ),
                          child: Column(
                            children: [
                              titleBarProfilePage(() {
                                Get.offAll(EditProfile());
                              }, screenSizeWidth),
                              SizedBox(
                                height: screenSizeheight * 0.16 - 48,
                              ),
                              ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(27.0),
                                    topRight: Radius.circular(27.0),
                                  ),
                                  child: BlurryContainer(
                                      blur: 7.5,
                                      color: backgroundAct.withOpacity(0.4),
                                      width: screenSizeWidth,
                                      height: screenSizeheight * 0.84,
                                      child: myText("")))
                            ],
                          )),
                      Padding(
                          padding:
                              EdgeInsets.only(top: screenSizeheight * 0.10),
                          child: Center(
                              child: FutureBuilder(
                                  future: controller.getUserData(),
                                  builder: (context, snapshot) {
                                    print(snapshot);
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshot.hasData) {
                                        UserModel userData =
                                            snapshot.data as UserModel;
                                        return CircleAvatar(
                                          radius: 46.0,
                                          backgroundColor: Colors.transparent
                                              .withOpacity(0.4),
                                          backgroundImage:
                                              NetworkImage(userData.profileUrl),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Center(
                                            child: Text(
                                                snapshot.error.toString()));
                                      } else {
                                        return Center(
                                            child:
                                                Text("Something went wrong"));
                                      }
                                    } else {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                  }))),
                      Padding(
                          padding: EdgeInsets.only(
                              top: screenSizeheight * 0.20,
                              left: screenSizeWidth * 0.12),
                          child: SizedBox(
                              height: 55.0,
                              child: Column(
                                children: [
                                  Expanded(
                                      child: myText("1500",
                                          weight: FontWeight.w700, size: 24.0)),
                                  Expanded(
                                      child:
                                          myText("Followers", colour: darktext))
                                ],
                              ))),
                      Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                              padding: EdgeInsets.only(
                                  top: screenSizeheight * 0.20,
                                  right: (screenSizeWidth * 0.12)),
                              child: SizedBox(
                                  height: 55.0,
                                  child: Column(
                                    children: [
                                      Expanded(
                                          child: myText("500",
                                              weight: FontWeight.w700,
                                              size: 24.0)),
                                      Expanded(
                                          child: myText("Following",
                                              colour: darktext))
                                    ],
                                  )))),
                      Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                              padding: EdgeInsets.only(
                                top: screenSizeheight * 0.27,
                              ),
                              child: SizedBox(
                                  height: 85.0,
                                  child: FutureBuilder(
                                    future: controller.getUserData(),
                                    builder: (context, snapshot) {
                                      print(snapshot);
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasData) {
                                          UserModel userData =
                                              snapshot.data as UserModel;

                                          return Column(
                                            children: [
                                              Expanded(
                                                  child: myText(
                                                      userData.fullName,
                                                      weight: FontWeight.w700,
                                                      size: 20.0)),
                                              SizedBox(height: 1.5),
                                              Expanded(
                                                  child: myText(
                                                      userData.userName,
                                                      colour: darktext,
                                                      size: 14.0)),
                                              SizedBox(height: 1.5),
                                              Expanded(
                                                  child: myText(
                                                      "if i sold that silk rug I'd be rich",
                                                      weight: FontWeight.w400,
                                                      colour: darktext,
                                                      size: 13.0))
                                            ],
                                          );
                                        } else if (snapshot.hasError) {
                                          return Center(
                                              child: Text(
                                                  snapshot.error.toString()));
                                        } else {
                                          return Center(
                                              child:
                                                  Text("Something went wrong"));
                                        }
                                      } else {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                    },
                                  )))),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: screenSizeheight * 0.40,
                                left: screenSizeWidth * 0.057),
                            child: registrationButton("Edit Profile", () {
                              Get.offAll(EditProfile());
                            }, primaryTextColor,
                                width: 165.0,
                                height: 40.0,
                                radius: 40.0,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400),
                          )),
                      Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: screenSizeheight * 0.40,
                                right: screenSizeWidth * 0.057),
                            child: registrationButton("Sign Out", () {
                              AuthController.authInstance.signOut();
                            }, Colors.black,
                                width: 165.0,
                                height: 40.0,
                                radius: 40.0,
                                fontSize: 12.0,
                                fontColor: mainColour,
                                fontWeight: FontWeight.w400),
                          )),
                      Padding(
                        padding:
                            EdgeInsets.only(top: screenSizeheight * 0.4667),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            myiconButtons(24.0, primaryTextColor, clicked,
                                CupertinoIcons.square_split_2x2),
                            myiconButtons(24.0, mainColour, clicked,
                                CupertinoIcons.person_2_square_stack),
                            myiconButtons(24.0, mainColour, clicked,
                                CupertinoIcons.add_circled)
                          ],
                        )),
                      ),
                      SizedBox(height: 11.0),
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0),
                        ),
                        child: Container(
                          width: screenSizeWidth,
                          padding: EdgeInsets.only(
                              top: screenSizeheight * 0.525,
                              left: (screenSizeWidth - 394.287) / 2,
                              right: (screenSizeWidth - 394.287) / 2),
                          child: UserPosts(),
                        ),
                      )
                    ],
                  ),
                ],
              )),
        ),
        bottomNavigationBar: tabBar());
  }
}
