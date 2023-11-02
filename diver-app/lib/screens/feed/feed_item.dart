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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0)),
            elevation: 3,
            color: Theme.of(context).brightness == Brightness.light
                ? const Color(0xFFFFFFFF)
                : const Color(0x1AFFFFFF),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
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
                            color: themeBasedDimmedContentColor(context)),
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
                        "vor 10min",
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
                                      padding: const EdgeInsets.all(16.0),
                                      child: Wrap(
                                        children: [
                                          ListTile(
                                            leading: Icon(Icons.report),
                                            title: Text("Report"),
                                            onTap: () {},
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.report),
                                            title: Text("Report"),
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
                        ?.copyWith(fontWeight: FontWeight.w100),
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
