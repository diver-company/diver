import 'package:auto_route/auto_route.dart';
import 'package:diver/core/supabase/supabase.dart';
import 'package:diver/models/post.model.dart';
import 'package:diver/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String timeAgoFromNow(DateTime createdAt) {
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

class FeedItem extends StatefulWidget {
  const FeedItem({super.key, required this.post});

  final PostModel post;

  @override
  State<FeedItem> createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {
  late String _postDate = 'jetzt';

  @override
  void initState() {
    super.initState();

    setState(() {
      _postDate = timeAgoFromNow(widget.post.createdAt);
    });
  }

  Future<void> _deletePost(BuildContext context) async {
    try {
      await supabase.from('posts').delete().match({ 'id': widget.post.id });

      if (context.mounted) {
        AutoRouter.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16.0),
            content: Text("Dein Post wurde erfolgreich gelöscht."),
          )
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0)),
            elevation: Theme.of(context).brightness == Brightness.light ? 2 : 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Erfurt",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        "•",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: themeBasedDimmedContentColor(context)),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        _postDate,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: themeBasedDimmedContentColor(context)),
                      ),
                      Expanded(child: Container()),
                      GestureDetector(
                        onTap: () {
                          Theme.of(context).platform == TargetPlatform.android
                              ? showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                                      child: Wrap(
                                        children: [
                                          if (widget.post.creator == supabase.auth.currentUser!.id)
                                            ListTile(
                                              leading: const Icon(Icons.delete_rounded),
                                              title: const Text("Delete post"),
                                              onTap: () => _deletePost(context),
                                            ),
                                          ListTile(
                                            leading: const Icon(Icons.report),
                                            title: const Text("Report"),
                                            onTap: () {},
                                          )
                                        ],
                                      ),
                                    );
                                  })
                              : showCupertinoModalPopup(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CupertinoActionSheet(
                                    actions: [
                                      if(widget.post.creator == supabase.auth.currentUser!.id)
                                        CupertinoActionSheetAction(
                                          isDestructiveAction: true,
                                          onPressed: () => _deletePost(context),
                                          child: const Text('Delete post'),
                                        ),
                                      CupertinoActionSheetAction(
                                        isDestructiveAction: true,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Report'),
                                      ),
                                    ],
                                    cancelButton: CupertinoActionSheetAction(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                  ),
                                );
                        },
                        child: const Icon(Icons.more_horiz, size: 20.0),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.post.text,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w100, height: 1.5),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _iconBuilder(context, Icons.favorite, widget.post.likes),
                      const SizedBox(width: 24),
                      _iconBuilder(context, Icons.forum, widget.post.comments),
                      const SizedBox(width: 24),
                      _iconBuilder(context, Icons.share, widget.post.shares)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _iconBuilder(BuildContext context, IconData icon, int count) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.0,
          color: themeBasedDimmedContentColor(context),
        ),
        const SizedBox(width: 4),
        Text(
          count.toString(),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: themeBasedDimmedContentColor(
                  context,
                ),
              ),
        ),
      ],
    );
  }
}
