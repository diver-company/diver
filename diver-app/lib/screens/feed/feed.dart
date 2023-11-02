import 'package:animations/animations.dart';
import 'package:diver/models/post.model.dart';
import 'package:diver/screens/feed/feed_item.dart';
import 'package:diver/screens/posts/post.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final ScrollController _scrollController = ScrollController();
  final List<PostModel> _list = List<PostModel>.generate(15, (index) =>
      PostModel(text: "$index Post", comments: index, likes: index * 1, shares: 0));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: ListView.separated(
        key: const PageStorageKey<String>('feedController'),
        controller: _scrollController,
        itemCount: _list.length,
        itemBuilder: (BuildContext context, int index) {
          return OpenContainer(
              closedColor: Colors.transparent,
              closedElevation: 0,
              openElevation: 0,
              closedBuilder: (BuildContext _, VoidCallback openContainer) {
                return FeedItem(post: _list[index]);
              },
              openBuilder: (BuildContext context, VoidCallback _) {
                return Post(post: _list[index]);
              },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 8);
        },
      ),
    );
  }
}
