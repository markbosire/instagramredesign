import 'dart:convert';
import 'package:http/http.dart' as http;

class CommentsRepository {
  static const String _baseUrl =
      'https://igredesign.babanovachrono.repl.co/posts';

  Future<int> sendComment(
      String postId, String content, DateTime commentDate) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/$postId/comments'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'content': content,
        'comment_date': commentDate.toIso8601String(),
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['comment_id'];
    } else {
      throw Exception(response.body);
    }
  }
}
