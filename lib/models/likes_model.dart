class Likes {
  Likes({
    this.isLiked = false,
    this.id,
    required this.postId,
    required this.email,
  });
  bool isLiked;
  int? id;
  String postId;
  String email;

  factory Likes.fromJson(Map<String, dynamic> json) => Likes(
        id: json["likes_id"],
        postId: json["post_id"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "likes_id": id,
        "post_id": postId,
        "email": email,
      };
}
