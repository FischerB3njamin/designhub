import 'package:flutter/material.dart';

class SectionInputfields extends StatelessWidget {
  final Function titleCallback;
  final Function descriptionCallback;
  final Function hashtagCallback;
  const SectionInputfields({
    super.key,
    required this.descriptionCallback,
    required this.hashtagCallback,
    required this.titleCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (e) => titleCallback(e),
          decoration: InputDecoration(
            hintText: "Title",
          ),
        ),
        SizedBox(height: 8),
        TextField(
          onChanged: (e) => descriptionCallback(e),
          decoration: InputDecoration(
            hintText: "Description",
          ),
        ),
        SizedBox(height: 8),
        TextField(
          onChanged: (e) => hashtagCallback(e),
          decoration: InputDecoration(
            hintText: "Hashtags",
          ),
        )
      ],
    );
  }
}
