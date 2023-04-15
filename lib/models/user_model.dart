import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String fullName;
  final String userName;
  final String email;
  final String profileUrl;

  UserModel(
      {this.id,
      required this.email,
      required this.userName,
      required this.fullName,
      required this.profileUrl});

  // ignore: empty_constructor_bodies
  toJson() {
    return {
      "FullName": fullName,
      "Email": email,
      "userName": userName,
      "profileUrl": profileUrl
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        id: document.id,
        email: data["Email"],
        userName: data["userName"],
        fullName: data["FullName"],
        profileUrl: data["profileUrl"]);
  }
}
