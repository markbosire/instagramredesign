// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:instagram_redesign/configurations/colors.dart';
import 'package:instagram_redesign/views/components/mycustomwidgets.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  void clicked() {
    print("is clicked");
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
            child: Scaffold(
          body: Container(
              color: backgroundAct,
              child: ListView(
                children: [
                  titleBar("Activity"),
                  SizedBox(height: 15.0),
                  Container(
                      height: 93.0,
                      child: ListView(children: [
                        SizedBox(
                            height: 93.0,
                            child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  SizedBox(width: 15.0),
                                  followBack(
                                      "https://i.pinimg.com/564x/6f/ab/d8/6fabd8b3e25d7c45c16de570fa8570f5.jpg",
                                      clicked),
                                  SizedBox(width: 15.0),
                                  followBack(
                                      "https://i.pinimg.com/564x/8e/2a/e4/8e2ae47845d6963f3aaf6abe2efbc8ad.jpg",
                                      clicked),
                                  SizedBox(width: 15.0),
                                  followBack(
                                      "https://i.pinimg.com/564x/3e/60/85/3e6085e78d044598d9b89feefcdd08a2.jpg",
                                      clicked),
                                  SizedBox(width: 15.0),
                                  followBack(
                                      "https://i.pinimg.com/564x/b4/fa/b7/b4fab7dfbbbbf941915b78de21e3a41d.jpg",
                                      clicked),
                                ])),
                      ])),
                  SizedBox(
                    height: 25.0,
                  ),
                  Container(
                      height: 500.0,
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: ListView(children: [
                        myText("TODAY(15)", size: 13.0),
                        SizedBox(height: 15.0),
                        interaction(
                            "https://i.pinimg.com/564x/6f/ab/d8/6fabd8b3e25d7c45c16de570fa8570f5.jpg",
                            "kira",
                            "4m",
                            "Liked your post"),
                        SizedBox(height: 15.0),
                        interaction(
                            "https://i.pinimg.com/564x/6f/ab/d8/6fabd8b3e25d7c45c16de570fa8570f5.jpg",
                            "kira",
                            "4m",
                            "Liked your post"),
                        SizedBox(height: 15.0),
                        interaction(
                            "https://i.pinimg.com/564x/6f/ab/d8/6fabd8b3e25d7c45c16de570fa8570f5.jpg",
                            "kira",
                            "4m",
                            "Liked your post"),
                        SizedBox(height: 15.0),
                        interaction(
                            "https://i.pinimg.com/564x/6f/ab/d8/6fabd8b3e25d7c45c16de570fa8570f5.jpg",
                            "kira",
                            "4m",
                            "Liked your post"),
                        SizedBox(height: 15.0),
                        interaction(
                            "https://i.pinimg.com/564x/6f/ab/d8/6fabd8b3e25d7c45c16de570fa8570f5.jpg",
                            "kira",
                            "4m",
                            "Liked your post"),
                        SizedBox(height: 15.0),
                        interaction(
                            "https://i.pinimg.com/564x/6f/ab/d8/6fabd8b3e25d7c45c16de570fa8570f5.jpg",
                            "kira",
                            "4m",
                            "Liked your post"),
                        SizedBox(height: 15.0),
                        interaction(
                            "https://i.pinimg.com/564x/6f/ab/d8/6fabd8b3e25d7c45c16de570fa8570f5.jpg",
                            "kira",
                            "4m",
                            "Liked your post"),
                        SizedBox(height: 15.0),
                        interaction(
                            "https://i.pinimg.com/564x/6f/ab/d8/6fabd8b3e25d7c45c16de570fa8570f5.jpg",
                            "kira",
                            "4m",
                            "Liked your post"),
                        SizedBox(height: 15.0),
                        interaction(
                            "https://i.pinimg.com/564x/6f/ab/d8/6fabd8b3e25d7c45c16de570fa8570f5.jpg",
                            "kira",
                            "4m",
                            "Liked your post"),
                        SizedBox(height: 15.0),
                        interaction(
                            "https://i.pinimg.com/564x/6f/ab/d8/6fabd8b3e25d7c45c16de570fa8570f5.jpg",
                            "kira",
                            "4m",
                            "Liked your post"),
                        SizedBox(height: 15.0),
                        interaction(
                            "https://i.pinimg.com/564x/6f/ab/d8/6fabd8b3e25d7c45c16de570fa8570f5.jpg",
                            "kira",
                            "4m",
                            "Liked your post"),
                        SizedBox(height: 15.0),
                        interaction(
                            "https://i.pinimg.com/564x/6f/ab/d8/6fabd8b3e25d7c45c16de570fa8570f5.jpg",
                            "kira",
                            "4m",
                            "Liked your post"),
                      ]))
                ],
              )),
        )));
  }
}
