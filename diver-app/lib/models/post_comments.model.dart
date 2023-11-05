class PostComment {
  final int id;
  final DateTime createdAt;
  final String userId;
  final int postId;
  final int? parentCommentId;
  final String text;

  PostComment({required this.id,
    required this.createdAt,
    required this.userId,
    required this.postId,
    required this.parentCommentId,
    required this.text});

  factory PostComment.fromJson(Map<String, dynamic> json) {
    return PostComment(
        id: json['id'] ?? -1,
        createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
        userId: json['user_id'] ?? '',
        postId: json['post_id'] ?? '',
        parentCommentId: json['parent_comment_id'],
        text: json['text']);
  }
}
