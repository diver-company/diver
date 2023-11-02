import 'package:diver/screens/feed/feed_item.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final List<String> _list = ["Test", "Test 2", "Test 3", "Test 4", "Test 5", "Test 6", "Test 7", "Test 8"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: ListView.separated(
        itemCount: _list.length,
        itemBuilder: (BuildContext context, int index) {
          return FeedItem(text: _list[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 8);
        },
      ),
    );
  }
}
