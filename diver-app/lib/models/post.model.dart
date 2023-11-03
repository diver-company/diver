import 'package:diver/core/supabase/supabase.dart';

class PostModel {
  final String text;
  final int comments;
  final int likes;
  final int shares;
  final DateTime createdAt;

  PostModel(
      {required this.text,
      required this.comments,
      required this.likes,
      required this.shares,
      required this.createdAt});

  static Future<List<PostModel>> getAll() async {
    try {
      final posts = await supabase.from('posts').select('*').order('created_at');
      final converted = posts
          .map((e) => PostModel.fromJson(e))
          .toList()
          .cast<PostModel>();

      return converted;
    } catch (e) {
      print("EXCEPTION: $e");

      return [];
    }
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        text: json['text'],
        comments: json['comments'],
        likes: json['likes'],
        shares: json['shares'],
        createdAt: DateTime.parse(json['created_at'])
    );
  }
}
