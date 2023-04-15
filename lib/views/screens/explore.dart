// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:instagram_redesign/configurations/colors.dart';
import 'package:instagram_redesign/views/components/mycustomwidgets.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: SafeArea(
          child: Scaffold(
              backgroundColor: Colors.white,
              // ignore: avoid_unnecessary_containers
              body: Container(
                padding: EdgeInsets.only(left: 18.0, right: 18.0),
                child: ListView(children: [
                  titleBar("Search"),
                  SizedBox(height: 15.0),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                      bottomRight: Radius.circular(50.0),
                      bottomLeft: Radius.circular(50.0),
                    ),
                    child: mytextField("Search", Icons.search,
                        radius: 50.0, colour: greyVariant),
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
                        width: double.infinity,
                        child: Column(
                          children: [
                            /* exploreWidgetRow(
                                "jojo1.jpg", "jojo2.png", "jojo3.png"),
                            SizedBox(height: 5.0),
                            exploreWidgetRow(
                                "jojo4.png", "jojo5.png", "jojo6.png"),
                            SizedBox(height: 5.0),
                            exploreWidgetRow(
                                "jojo7.png", "jojo8.png", "jojo3.png"),
                            SizedBox(height: 5.0),
                            exploreWidgetRow(
                                "jojo1.jpg", "jojo2.png", "jojo3.png"),
                            SizedBox(height: 5.0),
                            exploreWidgetRow(
                                "jojo1.jpg", "jojo2.png", "jojo3.png")*/
                          ],
                        )),
                  )
                ]),
              ))),
    );
  }
}
