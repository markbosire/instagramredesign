import 'dart:convert';
import 'package:http/http.dart' as http;

class SQLPost {
  final int postid;
  final String email;

  SQLPost({required this.postid, required this.email});

  factory SQLPost.fromJson(Map<String, dynamic> json) {
    return SQLPost(
      postid: json['postid'],
      email: json['email'],
    );
  }
}
