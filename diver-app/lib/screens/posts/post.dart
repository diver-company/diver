import 'package:diver/models/post.model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Post extends StatefulWidget {
  const Post({super.key, required this.post});

  final PostModel post;

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Post",
          style: GoogleFonts.yesevaOne(fontSize: 32.0),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
