class Comment {
  int? comment_id;
  bool isSelected;
  final String email;
  final String commentDate;
  final String comment;
  final String postId;

  Comment(
      {this.isSelected = false,
      this.comment_id,
      required this.email,
      required this.commentDate,
      required this.comment,
      required this.postId});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      comment_id: json["comment_id"],
      email: json['email'],
      commentDate: json['commentdate'],
      comment: json['comment'],
      postId: json['postid'],
    );
  }

  toJson() {
    return {
      'comment_id': comment_id,
      'email': email,
      'commentdate': commentDate,
      'comment': comment,
      'postid': postId,
    };
  }
}
