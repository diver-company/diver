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
  late List<PostModel> _posts = [];
  late StreamSubscription _streamPostsSubscription;

  final _postsStream = supabase.from('posts').stream(primaryKey: ['id']).order('created_at');

  @override
  void initState() {
    super.initState();

    _streamPostsSubscription = _postsStream.listen((event) {
      List<PostModel> posts = event.map((e) => PostModel.fromJson(e)).toList();

      setState(() {
        _posts = posts;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    _streamPostsSubscription.cancel();
  }

  Future<void> _refreshPosts() async {
    setState(() {
      _posts = [];
    });

    final newPosts = await PostModel.getAll();

    setState(() {
      _posts = newPosts;
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
          itemCount: _posts.length,
          itemBuilder: (BuildContext context, int index) {
            return OpenContainer(
              closedColor: Colors.transparent,
              closedElevation: 0,
              openElevation: 0,
              closedBuilder: (BuildContext _, VoidCallback openContainer) => FeedItem(post: _posts[index]),
              openBuilder: (BuildContext context, VoidCallback _) =>
                  Post(postId: _posts[index].id),
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
