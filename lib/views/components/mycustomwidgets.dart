// ignore_for_file: prefer_const_constructors, sort_child_properties_last, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_redesign/configurations/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dashed_circle/dashed_circle.dart';
import 'package:flutter/cupertino.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:instagram_redesign/views/screens/feed.dart';
import 'package:instagram_redesign/views/screens/profile_page.dart';
import 'package:instagram_redesign/views/screens/uploadimage.dart';

Widget logoImageAsset(String link,
    {scale = 2.0, height = 40.0, width = 40.0, radius = 12.0}) {
  return Image.asset(
    'assets/images/$link',
    scale: scale,
    height: height,
  );
}

Text myText(label,
    {var size = 14.0, var colour = mainColour, var weight = FontWeight.w500}) {
  return Text(
    label,
    style: GoogleFonts.poppins(
      textStyle: TextStyle(color: colour, fontSize: size, fontWeight: weight),
    ),
  );
}

Widget registrationButton(String name, Function? action, var color,
    {width = double.infinity,
    height = 60.0,
    radius = 14.0,
    String? link,
    fontSize = 14.0,
    fontWeight = FontWeight.w500,
    fontColor = Colors.white}) {
  // ignore: sized_box_for_whitespace
  return (Container(
      width: width,
      height: height,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius), // <-- Radius
              ),
              backgroundColor: color,
              textStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: fontColor,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w500))),
          onPressed: () {
            action!();
          },
          child: link != null
              ? Center(
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    logoImageAsset(link, scale: 1.2),
                    Text(name, textDirection: TextDirection.ltr),
                  ],
                ))
              : Text(name, textDirection: TextDirection.ltr))));
}

Widget backButton(
    {colour = Colors.black,
    icon = Icons.arrow_back_ios_new,
    page = const ProfilePage()}) {
  return ElevatedButton(
      onPressed: () {
        Get.to(page);
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: Colors.white,
        fixedSize: const Size(36, 36),
      ),
      child: Icon(
        icon,
        size: 14.0,
        color: colour,
      ));
}

Widget mytextField(String name, var iconImage,
    {double radius = 10.0,
    colour = Colors.black,
    image2,
    controller,
    obscure = false}) {
  return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
        bottomLeft: Radius.circular(radius),
        bottomRight: Radius.circular(radius),
      ),
      child: Container(
        color: greyVariant15,
        width: double.infinity,
        child: TextFormField(
          obscureText: obscure,
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(iconImage, color: colour),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide:
                  BorderSide(width: 1, color: greyVariant), //<-- SEE HERE
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide:
                  BorderSide(width: 1, color: greyVariant), //<-- SEE HERE
            ),
            hintText: name,
            hintStyle: TextStyle(color: colour),
            contentPadding: EdgeInsets.symmetric(vertical: 18.0),
          ),
        ),
      ));
}

Widget mypasswordField(String name, var iconImage,
    {double radius = 10.0,
    colour = Colors.black,
    image2,
    controller,
    toggleObscureText,
    obscure = false}) {
  return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
        bottomLeft: Radius.circular(radius),
        bottomRight: Radius.circular(radius),
      ),
      child: Container(
        color: greyVariant15,
        width: double.infinity,
        child: TextFormField(
          obscureText: obscure,
          controller: controller,
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
                onTap: toggleObscureText,
                child: Icon(
                  obscure ? Icons.visibility_off : Icons.visibility,
                  color: colour,
                  size: 20.0,
                )),
            prefixIcon: Icon(iconImage, color: colour),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide:
                  BorderSide(width: 1, color: greyVariant), //<-- SEE HERE
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide:
                  BorderSide(width: 1, color: greyVariant), //<-- SEE HERE
            ),
            hintText: name,
            hintStyle: TextStyle(color: colour),
            contentPadding: EdgeInsets.symmetric(vertical: 18.0),
          ),
        ),
      ));
}

Widget myStories(url) {
  return CircleAvatar(
      radius: 30.0,
      backgroundColor: storyColour,
      child: CircleAvatar(
          radius: 27.0,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 24.0,
            backgroundImage: NetworkImage(url),
          )));
}

Widget myiconButtons(var size, var color, Function action, var icon,
    {splash = Colors.transparent}) {
  return IconButton(
    splashColor: splash,
    iconSize: size,
    color: color,
    onPressed: () {
      action();
    },
    icon: Icon(
      icon,
    ),
  );
}

Widget addStory(action) {
  return CircleAvatar(
      radius: 30.0,
      backgroundColor: greyVariant,
      child: CircleAvatar(
        radius: 29.0,
        backgroundColor: Colors.white,
        child: DashedCircle(
          dashes: 8,
          strokeWidth: 0.2,
          color: greyVariant,
          child: myiconButtons(24.0, buttonColor, action, Icons.add),
        ),
      ));
}

Widget commentTitle(url, username, time, description) {
  return FutureBuilder<String>(
    future: url,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return ListTile(
            leading: CircleAvatar(
              radius: 24.0,
              backgroundImage: NetworkImage(snapshot.data!),
            ),
            title: Row(
                children: [myText(snapshot.data!), myText(" "), myText(time)]),
            subtitle: myText(description,
                weight: FontWeight.w400, colour: greyVariant, size: 12.0));
      } else {
        return CircularProgressIndicator(); // Or another loading indicator
      }
    },
  );
}

Widget commentTextField(url, controller, action) {
  return FutureBuilder<String>(
    future: url,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return TextField(
          controller: controller,
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
                onTap: action,
                child: Icon(
                  Icons.send,
                  color: mainColour,
                )),
            prefixIcon: SizedBox(
              width: 60.0,
              child: Row(
                children: [
                  SizedBox(
                    width: 5.0,
                  ),
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(snapshot.data!),
                  ),
                  SizedBox(
                    width: 5.0,
                  )
                ],
              ),
            ),
            border: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 0, color: greyVariant), //<-- SEE HERE
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 0, color: greyVariant), //<-- SEE HERE
            ),
            hintText: "Write your comment...",
            contentPadding: EdgeInsets.symmetric(vertical: 18.0),
          ),
        );
      } else {
        return CircularProgressIndicator(); // Or another loading indicator
      }
    },
  );
}

Widget post(
  url,
  username,
  location,
  link,
  action,
  deleteaction,
  commentQuantity,
  likeColor,
  likeQuantity,
  likeAction,
) {
  return Column(
    children: [
      ListTile(
          leading: CircleAvatar(
            radius: 24.0,
            backgroundImage: NetworkImage(url),
          ),
          title: myText(username),
          subtitle: myText(location,
              weight: FontWeight.w400, colour: greyVariant, size: 12.0),
          trailing: GestureDetector(
            onTap: deleteaction,
            child: Icon(
              CupertinoIcons.ellipsis_circle,
              size: 24,
              color: buttonColor,
            ),
          )),
      GestureDetector(
        onDoubleTap: likeAction,
        child: Container(
          height: 305,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: NetworkImage(link),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          )),
          child: Column(children: [
            SizedBox(
              height: 245.0,
            ),
            BlurryContainer(
              // ignore: sort_child_properties_last
              child: Row(
                children: [
                  SizedBox(
                    width: 7.0,
                  ),
                  BlurryContainer(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: likeAction,
                            child: Icon(
                              Icons.favorite,
                              color: likeColor,
                              size: 24.0,
                            ),
                          ),
                          myText(" $likeQuantity ",
                              size: 13.0, colour: buttonColor)
                        ]),
                    blur: 5.0,
                    width: 82.0,
                    height: 34.0,
                    elevation: 0.0,
                    color: Colors.white38,
                    padding: EdgeInsets.all(2.0),
                    borderRadius: BorderRadius.all(Radius.circular(80.0)),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  GestureDetector(
                    onTap: action,
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.conversation_bubble,
                          size: 24.0,
                          color: buttonColor,
                        ),
                        myText(" $commentQuantity ",
                            size: 13.0, colour: buttonColor)
                      ],
                    ),
                  ),
                  SizedBox(width: 12.0),
                  Icon(
                    CupertinoIcons.location,
                    color: buttonColor,
                    size: 24.0,
                  ),
                  SizedBox(width: 101.0),
                  Icon(
                    CupertinoIcons.bookmark,
                    color: buttonColor,
                    size: 24.0,
                  )
                ],
              ),
              blur: 5.0,
              width: 342.0,
              height: 50.0,
              elevation: 0.0,
              color: Color(0xFFFFFFFF).withOpacity(0.5),
              padding: EdgeInsets.all(4),
              borderRadius: BorderRadius.all(Radius.circular(80.0)),
            )
          ]),
        ),
      ),
    ],
  );
}

Widget exploreWidgetRow({var image1, var image2, var image3}) {
  return Row(
    children: [
      explorePost(image1),
      SizedBox(width: 5.0),
      explorePost(image2),
      SizedBox(width: 5.0),
      explorePost(image3)
    ],
  );
}

Widget tabBar() {
  return CupertinoTabBar(
      border: Border(
          top: BorderSide(
        color: Colors.grey,
        width: 0.2, // 0.0 means one physical pixel
      )),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: GestureDetector(
                onTap: () {
                  Get.offAll(MyPage());
                },
                child: Icon(Icons.home_sharp, color: buttonColor))),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search, color: buttonColor)),
        BottomNavigationBarItem(
          icon: GestureDetector(
            onTap: () {
              Get.offAll(UploadPage());
            },
            child: Icon(
              CupertinoIcons.add_circled,
              color: storyColour,
            ),
          ),
        ),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.play_rectangle, color: buttonColor)),
        BottomNavigationBarItem(
            icon: GestureDetector(
                onTap: () {
                  Get.offAll(ProfilePage());
                },
                child: Icon(CupertinoIcons.person_alt_circle,
                    color: buttonColor))),
      ]);
}

Widget explorePost(var image) {
  return Container(
      margin: EdgeInsets.all(2.5),
      height: 121.429,
      width: 121.429,
      decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 0.1,
            ),
          ),
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          )));
}

Widget titleBar(text, {page = const ProfilePage()}) {
  return Row(children: [
    backButton(colour: greyVariant, page: page),
    SizedBox(width: 111.0),
    myText(text, size: 17.0, colour: buttonColor)
  ]);
}

Widget titleBarProfilePage(action, screenWidth) {
  return SizedBox(
      width: screenWidth,
      child: Align(
          alignment: Alignment.topRight,
          child: myiconButtons(28.0, Colors.white, action, Icons.menu)));
}

Widget followBack(link, action) {
  return Column(children: [
    myStories(link),
    SizedBox(height: 5.0),
    registrationButton("Follow", action, primaryTextColor,
        width: 80.0, height: 28.0, fontSize: 12.0, fontWeight: FontWeight.w200),
  ]);
}

Widget interaction(link, uname, time, activity) {
  return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12.0),
        topRight: Radius.circular(12.0),
        bottomLeft: Radius.circular(12.0),
        bottomRight: Radius.circular(12.0),
      ),
      child: Container(
          color: Colors.white,
          height: 70.0,
          child: ListTile(
            leading: myStories(link),
            title: Row(
              children: [
                myText(uname, size: 13.0),
                myText(" $time ago", size: 13.0, colour: greyVariant)
              ],
            ),
            subtitle: myText(activity, size: 13.0, colour: greyVariant),
            trailing: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                  bottomLeft: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0),
                ),
                child: Container(
                    width: 43.0,
                    height: 43.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/avatar.png"),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    child: myText(""))),
          )));
}

Widget profileWidget(name, value) {
  return ClipRRect(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(12.0),
      topRight: Radius.circular(12.0),
      bottomLeft: Radius.circular(12.0),
      bottomRight: Radius.circular(12.0),
    ),
    child: Container(
      color: Colors.white,
      child: ListTile(
        title: myText(name, weight: FontWeight.w600, colour: greyVariant),
        subtitle: myText(value, size: 12.0, colour: darktext),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 20.0,
        ),
      ),
    ),
  );
}

Widget progressIndicator(mycolor, width, {active = 1}) {
  return Container(
    width: 208.0,
    alignment: Alignment.center,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        progressCircle("1", active == 1 ? mainColour : mycolor),
        SizedBox(
          width: 5.0,
        ),
        Container(
          height: 1.0,
          width: 40.0,
          color: Colors.black,
        ),
        SizedBox(
          width: 5.0,
        ),
        progressCircle("2", active == 2 ? mainColour : mycolor),
        SizedBox(
          width: 5.0,
        ),
        Container(
          height: 1.0,
          width: 40.0,
          color: Colors.black,
        ),
        SizedBox(
          width: 5.0,
        ),
        progressCircle("3", active == 3 ? mainColour : mycolor)
      ],
    ),
  );
}

Widget progressCircle(mynum, mycolor) {
  return CircleAvatar(
    backgroundColor: mycolor,
    radius: (18),
    child: CircleAvatar(
      radius: 15,
      backgroundColor: Colors.white,
      child: myText(mynum),
    ),
  );
}

Widget userProfile(link) {
  return CircleAvatar(
    radius: 60.0,
    backgroundColor: Colors.transparent.withOpacity(0.4),
    backgroundImage: link != null ? FileImage(link) : null,
    child: CircleAvatar(
      radius: 60.0,
      backgroundColor: Colors.grey.withOpacity(0.6),
      child: Icon(
        Icons.camera_alt,
        size: 50.0,
        color: darktext,
      ),
    ),
  );
}
