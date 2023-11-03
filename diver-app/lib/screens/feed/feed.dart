import 'dart:async';

import 'package:animations/animations.dart';
import 'package:auto_route/annotations.dart';
import 'package:diver/core/supabase/supabase.dart';
import 'package:diver/models/post.model.dart';
import 'package:diver/screens/feed/feed_item.dart';
import 'package:diver/screens/posts/post.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final ScrollController _scrollController = ScrollController();
  late List<PostModel> posts = [];
  late StreamSubscription _streamSubscription;

  final _stream = supabase.from('posts').stream(primaryKey: ['id']);

  @override
  void initState() {
    super.initState();

    _streamSubscription = _stream.listen((event) {
      PostModel.getAll().then((value) {
        setState(() {
          posts = value;
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    _streamSubscription.cancel();
  }

  Future<void> _refreshPosts() async {
    final newPosts = await PostModel.getAll();

    setState(() {
      posts = newPosts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: RefreshIndicator(
        onRefresh: _refreshPosts,
        child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          key: const PageStorageKey<String>('feedController'),
          controller: _scrollController,
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int index) {
            return OpenContainer(
              closedColor: Colors.transparent,
              closedElevation: 0,
              openElevation: 0,
              closedBuilder: (BuildContext _, VoidCallback openContainer) => FeedItem(post: posts[index]),
              openBuilder: (BuildContext context, VoidCallback _) =>
                  Post(post: posts[index]),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 8);
          },
        ),
      ),
    );
  }
}
