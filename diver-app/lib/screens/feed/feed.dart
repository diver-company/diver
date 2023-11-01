import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int idx) {
          return Column(
            children: [
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 86.0,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: Theme.of(context).colorScheme.secondary),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
