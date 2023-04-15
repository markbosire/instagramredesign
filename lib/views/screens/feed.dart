// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:instagram_redesign/configurations/colors.dart';
import 'package:instagram_redesign/controllers/unsplash_controller.dart';
import 'package:instagram_redesign/views/components/image_list_fb.dart';
import 'package:instagram_redesign/views/components/mycustomwidgets.dart';

import 'package:flutter/cupertino.dart';

// ignore: use_key_in_widget_constructors
class MyPage extends StatelessWidget {
  const MyPage({super.key});

  void clicked() {
    print("is clicked");
  }

  /// Widget
  @override
  Widget build(BuildContext context) {
    var screenSizeheight = MediaQuery.of(context).size.height;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
            child: Scaffold(
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  myText("  "),
                                  logoImageAsset("logo.png", scale: 1.3),
                                  myText(" Instagram",
                                      size: 18.0,
                                      weight: FontWeight.w500,
                                      colour: buttonColor),
                                ]),
                                Row(
                                  children: [
                                    myiconButtons(24.0, buttonColor, clicked,
                                        Icons.search),
                                    myiconButtons(24.0, buttonColor, clicked,
                                        Icons.favorite_outline),
                                    myiconButtons(24.0, buttonColor, clicked,
                                        CupertinoIcons.paperplane),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 15.0),
                            Column(
                              children: [
                                SizedBox(
                                    height: 85.0,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        SizedBox(width: 15.0),
                                        Column(children: [
                                          addStory(clicked),
                                          SizedBox(height: 5.0),
                                          myText("You",
                                              size: 12.0,
                                              weight: FontWeight.w500,
                                              colour: buttonColor),
                                        ]),
                                        SizedBox(width: 20.0),
                                        Column(children: [
                                          myStories(
                                              "https://i.pinimg.com/564x/6f/ab/d8/6fabd8b3e25d7c45c16de570fa8570f5.jpg"),
                                          SizedBox(height: 5.0),
                                          myText("Kira",
                                              size: 12.0,
                                              weight: FontWeight.w500,
                                              colour: buttonColor),
                                        ]),
                                        SizedBox(width: 20.0),
                                        Column(children: [
                                          myStories(
                                              "https://i.pinimg.com/564x/8e/2a/e4/8e2ae47845d6963f3aaf6abe2efbc8ad.jpg"),
                                          SizedBox(height: 5.0),
                                          myText("Itachi",
                                              size: 12.0,
                                              weight: FontWeight.w500,
                                              colour: buttonColor),
                                        ]),
                                        SizedBox(width: 20.0),
                                        Column(children: [
                                          myStories(
                                              "https://i.pinimg.com/564x/3e/60/85/3e6085e78d044598d9b89feefcdd08a2.jpg"),
                                          SizedBox(height: 5.0),
                                          myText("Johann ",
                                              size: 12.0,
                                              weight: FontWeight.w500,
                                              colour: buttonColor),
                                        ]),
                                        SizedBox(width: 20.0),
                                        Column(children: [
                                          myStories(
                                              "https://i.pinimg.com/564x/b4/fa/b7/b4fab7dfbbbbf941915b78de21e3a41d.jpg"),
                                          SizedBox(height: 5.0),
                                          myText("Bachira ",
                                              size: 12.0,
                                              weight: FontWeight.w500,
                                              colour: buttonColor),
                                        ]),
                                      ],
                                    )),
                                PostsPage()
                              ],
                            )
                          ],
                        ))),
                bottomNavigationBar: tabBar())));
  }
}
