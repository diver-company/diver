import 'package:diver/core/supabase/supabase.dart';

class PostModel {
  final int id;
  final String creator;
  final String text;
  final int comments;
  final int likes;
  final int shares;
  final DateTime createdAt;

  PostModel(
      {required this.id,
      required this.creator,
      required this.text,
      required this.comments,
      required this.likes,
      required this.shares,
      required this.createdAt});

  static Future<List<PostModel>> getAll() async {
    try {
      final posts =
          await supabase.from('posts').select('*').order('created_at');
      final converted =
          posts.map((e) => PostModel.fromJson(e)).toList().cast<PostModel>();

      return converted;
    } catch (e) {
      print("EXCEPTION: $e");

      return [];
    }
  }

  static Future<PostModel?> getOneBy(String columnName, int rowId) async {
    try {
      final dynamic post = await supabase.from('posts').select('*').eq('id', rowId).single();

      return PostModel.fromJson(post);
    } catch(e) {
      print("EXCEPTION: $e");

      return null;
    }
  }

  String timeAgoFromNow() {
    Duration difference = DateTime.now().difference(createdAt);

    if (difference.inSeconds < 60) {
      return 'jetzt';
    } else if (difference.inMinutes < 60) {
      return 'vor ${difference.inMinutes} Minute${difference.inMinutes == 1 ? '' : 'n'}';
    } else if (difference.inHours < 24) {
      return 'vor ${difference.inHours} Stunde${difference.inHours == 1 ? '' : 'n'}';
    } else if (difference.inDays < 30) {
      return 'vor ${difference.inDays} Tag${difference.inDays == 1 ? '' : 'en'}';
    } else {
      int monthsDifference = difference.inDays ~/ 30;
      return 'vor $monthsDifference Monat${monthsDifference == 1 ? '' : 'en'}';
    }
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        id: json['id'] ?? -1,
        creator: json['creator'] ?? '',
        text: json['text'] ?? '',
        comments: json['comments'] ?? 0,
        likes: json['likes'] ?? 0,
        shares: json['shares'] ?? 0,
        createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toString())
    );
  }
}
