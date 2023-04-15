import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_redesign/configurations/colors.dart';
import 'package:instagram_redesign/views/components/mycustomwidgets.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:instagram_redesign/views/screens/profile_page.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSizeheight = MediaQuery.of(context).size.height;
    var screenSizeWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Container(
      height: screenSizeheight,
      color: backgroundAct,
      child: Column(children: [
        titleBar("Edit Profile", page: const ProfilePage()),
        Padding(
          padding: EdgeInsets.only(
              left: screenSizeWidth * 0.05, right: screenSizeWidth * 0.05),
          child: Column(
            children: [
              SizedBox(height: screenSizeheight * 0.05),
              Center(
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundColor: Colors.transparent.withOpacity(0.4),
                  backgroundImage: AssetImage("assets/images/Otto.png"),
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundColor: Colors.grey.withOpacity(0.6),
                    child: Icon(
                      Icons.camera_alt,
                      size: 50.0,
                      color: darktext,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenSizeheight * 0.025),
              profileWidget("Username", "quandale.ding23"),
              SizedBox(height: screenSizeheight * 0.01),
              profileWidget("Fullname", "Quandale Dingle"),
              SizedBox(height: screenSizeheight * 0.01),
              profileWidget("Bio", "Quandale Dingle here"),
              SizedBox(height: screenSizeheight * 0.01),
              profileWidget("Links", "Of.com/qd"),
              SizedBox(height: screenSizeheight * 0.025),
              myText("Personal information settings", colour: primaryTextColor)
            ],
          ),
        )
      ]),
    ))));
  }
}
