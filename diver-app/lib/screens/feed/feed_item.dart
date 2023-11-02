import 'package:diver/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedItem extends StatefulWidget {
  const FeedItem({super.key, required this.text});

  final String text;

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
                          Theme.of(context).platform == TargetPlatform.android ? showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container();
                              }
                          ) : showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext context) => CupertinoActionSheet(
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
                    widget.text,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w100,
                          height: 1.5,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            size: 12.0,
                            color: themeBasedDimmedContentColor(context),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "4",
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: themeBasedDimmedContentColor(
                                        context,
                                      ),
                                    ),
                          )
                        ],
                      ),
                      const SizedBox(width: 24),
                      Row(
                        children: [
                          Icon(
                            Icons.forum,
                            size: 12.0,
                            color: themeBasedDimmedContentColor(context),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "2",
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: themeBasedDimmedContentColor(
                                        context,
                                      ),
                                    ),
                          )
                        ],
                      ),
                      const SizedBox(width: 24),
                      Row(
                        children: [
                          Icon(
                            Icons.share,
                            size: 12.0,
                            color: themeBasedDimmedContentColor(context),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "0",
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: themeBasedDimmedContentColor(
                                        context,
                                      ),
                                    ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
