import 'package:designhub/features/posts/widgets/card_with_profile_name.dart';
import 'package:designhub/features/posts/widgets/card_with_title.dart';
import 'package:flutter/material.dart';

class SectionProfileCard extends StatelessWidget {
  final List<String> postIds;
  final String type; // title or name
  const SectionProfileCard(
      {super.key, required this.postIds, required this.type});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: 400,
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          physics: NeverScrollableScrollPhysics(),
          children: [
            ...postIds.map((e) => type == "title"
                ? CardWithTitle(postId: e)
                : CardWithProfileName(postId: e)),
          ],
        ),
      ),
    );
  }
}
