import 'dart:async';

import 'package:diver/core/supabase/supabase.dart';
import 'package:diver/models/post.model.dart';
import 'package:diver/models/post_comments.model.dart';
import 'package:diver/models/post_likes.model.dart';
import 'package:diver/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reactive_forms/reactive_forms.dart';

class Post extends StatefulWidget {
  const Post({super.key, required this.postId});

  final int postId;

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  bool _loading = true;
  late bool _likedByCurrentUser = false;
  late StreamSubscription _streamLikesSubscription;
  late StreamSubscription _streamCommentsSubscription;
  late StreamSubscription _streamPostSubscription;

  late PostModel _post;
  late List<PostLike> _postLikes = [];
  late List<PostComment> _postComments = [];

  final _form = fb.group({
    'comment': ['']
  });

  @override
  void initState() {
    super.initState();

    _streamPostSubscription = supabase
        .from('posts')
        .stream(primaryKey: ['id'])
        .eq('id', widget.postId)
        .listen((event) {
          List<PostModel> posts =
              event.map((e) => PostModel.fromJson(e)).toList();
          setState(() {
            _post = posts.first;
            _loading = false;
          });
        });

    _streamCommentsSubscription = supabase
        .from('post_comments')
        .stream(primaryKey: ['id'])
        .eq('post_id', widget.postId)
        .listen((event) {
          List<PostComment> comments = event.map((e) => PostComment.fromJson(e)).toList();

          setState(() {
            _postComments = comments;
          });
    });

    _streamLikesSubscription = supabase
        .from('post_likes')
        .stream(primaryKey: ['id'])
        .eq('post_id', widget.postId)
        .listen((event) {
          List<PostLike> likes =
              event.map((e) => PostLike.fromJson(e)).toList();

          setState(() {
            _postLikes = likes;
            _likedByCurrentUser = likes.any((element) =>
                element.userId == supabase.auth.currentUser!.id &&
                element.postId == widget.postId);
          });
        });
  }

  @override
  void dispose() {
    super.dispose();

    _streamLikesSubscription.cancel();
    _streamCommentsSubscription.cancel();
    _streamPostSubscription.cancel();
  }

  Future<void> _removeLike() async {
    await supabase
        .rpc('decrement_likes', params: {'decrementby': 1, 'row_id': _post.id});

    await supabase
        .from('post_likes')
        .delete()
        .eq('user_id', supabase.auth.currentUser!.id)
        .eq('post_id', _post.id);

    setState(() {
      _likedByCurrentUser = false;
    });
  }

  Future<void> _likePost() async {
    await supabase
        .rpc('increment_likes', params: {'incrementby': 1, 'row_id': _post.id});

    await supabase
        .from('post_likes')
        .insert({'post_id': _post.id, 'user_id': supabase.auth.currentUser!.id});

    setState(() {
      _likedByCurrentUser = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Post",
          style: GoogleFonts.yesevaOne(fontSize: 32),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: _loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Erfurt",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold)),
                      const SizedBox(width: 4),
                      Text(
                        "•",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: themeBasedDimmedContentColor(context),
                            ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _post.timeAgoFromNow(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: themeBasedDimmedContentColor(context)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(_post.text),
                  const SizedBox(height: 8),
                  Divider(color: themeBasedDimmedContentColor(context)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _post.creator != supabase.auth.currentUser!.id
                          ? _likeButtonBuilder(context, _postLikes.length)
                          : _iconBuilder(context, Icons.favorite_rounded,
                              _postLikes.length),
                      const SizedBox(width: 24),
                      _iconBuilder(context, Icons.forum_rounded, _post.comments),
                      const SizedBox(width: 24),
                      _iconBuilder(context, Icons.share_rounded, _post.shares)
                    ],
                  ),
                  Expanded(
                      flex: 1,
                      child: _postComments.length == 0 ? Center(
                        child: Text("No comments yet."),
                      ) : Column(
                        children: [],
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ReactiveForm(
                      formGroup: _form,
                      child: ReactiveFormConsumer(
                        builder: (context, formGroup, child) =>
                            ReactiveTextField(
                          formControlName: 'comment',
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: themeBasedBorderSide(context)),
                              hintText: "Write a comment...",
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.send_rounded),
                              ),
                              suffixIconColor: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _iconBuilder(BuildContext context, IconData icon, int count) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20.0,
          color: themeBasedDimmedContentColor(context),
        ),
        const SizedBox(width: 4),
        Text(
          count.toString(),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: themeBasedDimmedContentColor(
                  context,
                ),
              ),
        ),
      ],
    );
  }

  Widget _likeButtonBuilder(BuildContext context, int count) {
    return _likedByCurrentUser
        ? FilledButton.icon(
            onPressed: _removeLike,
            icon: const Icon(
              Icons.favorite_rounded,
              size: 20,
              color: Colors.white,
            ),
            label: Text(
              "$count",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white),
            ),
          )
        : OutlinedButton.icon(
            onPressed: _likePost,
            icon: Icon(
              Icons.favorite_border_rounded,
              size: 20,
              color: themeBasedDimmedContentColor(context),
            ),
            label: Text(
              "$count",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
  }
}
