import 'package:firebase_auth/firebase_auth.dart';

Future<bool> checkAuthState() async {
  FirebaseAuth auth = FirebaseAuth.instance;

  User? user = auth.currentUser;
  if (user != null) {
    return true;
  } else {
    return false;
  }
}
