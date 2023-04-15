import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String? id;
  final String imageUrl;
  final String userName;
  final String email;
  final String timestamp;

  PostModel({
    this.id,
    required this.email,
    required this.userName,
    required this.imageUrl,
    required this.timestamp,
  });

  // ignore: empty_constructor_bodies
  toJson() {
    return {
      "imageUrl": imageUrl,
      "Email": email,
      "userName": userName,
      "timestamp": timestamp
    };
  }

  factory PostModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return PostModel(
        id: document.id,
        email: data["Email"],
        userName: data["userName"],
        imageUrl: data["imageUrl"],
        timestamp: data["timestamp"]);
  }
}
