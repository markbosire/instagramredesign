import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_redesign/views/screens/feed.dart';
import 'package:instagram_redesign/views/screens/profile_page.dart';
import 'package:instagram_redesign/views/screens/welcome.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: FirebaseAuth.instance.authStateChanges().first,
          builder: (context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show a loading indicator while we wait for Firebase
              return CircularProgressIndicator();
            } else {
              // Navigate to the appropriate screen based on user auth state
              return snapshot.hasData ? MyPage() : MyWidget();
            }
          },
        ),
      ),
    );
  }
}
