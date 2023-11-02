import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "New",
          style: GoogleFonts.yesevaOne(fontSize: 32.0),
        ),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).pop(context),
              icon: const Icon(Icons.close)
          )
        ],
      ),
    );
  }
}
