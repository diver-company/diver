import 'package:auto_route/auto_route.dart';
import 'package:diver/core/supabase/supabase.dart';
import 'package:diver/models/post.model.dart';
import 'package:diver/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      _postDate = widget.post.timeAgoFromNow();
    });
  }

  Future<void> _deletePost(BuildContext context) async {
    try {
      final delete = await _dialogBuilder(context) ?? false;

      if (delete) {
        await supabase.from('posts').delete().match({'id': widget.post.id});

        if (context.mounted) {
          AutoRouter.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(16.0),
            content: Text("Dein Post wurde erfolgreich gelöscht."),
          ));
        }
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
              elevation:
                  Theme.of(context).brightness == Brightness.light ? 2 : 10,
              child: ClipPath(
                clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                          color: widget.post.creator == supabase.auth.currentUser!.id ? themeBasedDimmedContentColor(context) : Colors.transparent,
                          width: 4),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Erfurt",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                            ),
                            const SizedBox(width: 2),
                            Text(
                              "•",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: themeBasedDimmedContentColor(
                                          context)),
                            ),
                            const SizedBox(width: 2),
                            Text(
                              _postDate,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: themeBasedDimmedContentColor(
                                          context)),
                            ),
                            Expanded(child: Container()),
                            GestureDetector(
                              onTap: () {
                                Theme.of(context).platform ==
                                        TargetPlatform.android
                                    ? showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.0,
                                                right: 16.0,
                                                bottom: 16.0),
                                            child: Wrap(
                                              children: [
                                                if (widget.post.creator ==
                                                    supabase
                                                        .auth.currentUser!.id) ...[
                                                  ListTile(
                                                    leading: const Icon(
                                                        Icons.delete_rounded),
                                                    title: const Text(
                                                        "Delete post"),
                                                    onTap: () =>
                                                        _deletePost(context),
                                                  ),
                                                  Divider(
                                                    color: themeBasedDimmedContentColor(context),
                                                  )
                                                ],
                                                ListTile(
                                                  leading:
                                                      const Icon(Icons.report),
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
                                            if (widget.post.creator ==
                                                supabase.auth.currentUser!.id)
                                              CupertinoActionSheetAction(
                                                isDestructiveAction: true,
                                                onPressed: () =>
                                                    _deletePost(context),
                                                child:
                                                    const Text('Delete post'),
                                              ),
                                            CupertinoActionSheetAction(
                                              isDestructiveAction: true,
                                              onPressed: () => AutoRouter.of(context).pop(),
                                              child: const Text('Report'),
                                            ),
                                          ],
                                          cancelButton:
                                              CupertinoActionSheetAction(
                                            onPressed: () => AutoRouter.of(context).pop(),
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
                              ?.copyWith(
                                  fontWeight: FontWeight.w100, height: 1.5),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _iconBuilder(
                                context, Icons.favorite, widget.post.likes),
                            const SizedBox(width: 24),
                            _iconBuilder(
                                context, Icons.forum, widget.post.comments),
                            const SizedBox(width: 24),
                            _iconBuilder(
                                context, Icons.share, widget.post.shares)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )),
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

  Future<bool?> _dialogBuilder(BuildContext context) {
    return showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Delete post?"),
              content: Text("It is not possible to undo this action and your post is lost forever."),
              actions: <Widget>[
                TextButton(
                  onPressed: () => AutoRouter.of(context).pop(false),
                  child: Text("Cancel", style: Theme.of(context).textTheme.bodyMedium),
                ),
                FilledButton(
                  onPressed: () => AutoRouter.of(context).pop(true),
                  child: Text("Delete", style: Theme.of(context).textTheme.bodyMedium),
                )
              ],
            ));
  }
}
