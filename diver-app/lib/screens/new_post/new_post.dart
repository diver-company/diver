import 'package:flutter/material.dart';

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
        title: const Text("New post"),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(context),
            icon: const Icon(Icons.arrow_back)
        ),
      ),
    );
  }
}
