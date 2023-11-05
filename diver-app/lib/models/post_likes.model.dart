class PostLike {
  final int id;
  final DateTime createdAt;
  final int postId;
  final String userId;

  PostLike(
      {required this.id,
      required this.createdAt,
      required this.postId,
      required this.userId});

  factory PostLike.fromJson(Map<String, dynamic> json) {
    return PostLike(
        id: json['id'] ?? -1,
        createdAt:
            DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
        postId: json['post_id'] ?? '',
        userId: json['user_id'] ?? '');
  }
}
