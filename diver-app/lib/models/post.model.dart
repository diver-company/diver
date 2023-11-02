class PostModel {
  final String text;
  final int comments;
  final int likes;
  final int shares;

  const PostModel(
      {required this.text,
      required this.comments,
      required this.likes,
      required this.shares});
}
