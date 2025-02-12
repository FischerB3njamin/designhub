import 'package:designhub/features/posts/widgets/card_with_profile_name.dart';
import 'package:designhub/features/posts/widgets/card_with_title.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/shared/controller/controller.dart';
import 'package:flutter/material.dart';

class SectionProfilCard extends StatefulWidget {
  final Profile profile;
  final String type;
  const SectionProfilCard(
      {super.key, required this.profile, required this.type});

  @override
  State<SectionProfilCard> createState() => _SectionProfilCardState();
}

class _SectionProfilCardState extends State<SectionProfilCard> {
  @override
  Widget build(BuildContext context) {
    List<String> postIds = widget.type == 'title'
        ? Controller().profileDB.getProfile(widget.profile.userId).posts
        : Controller().profileDB.getProfile(widget.profile.userId).savedPosts;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: 400,
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: [
            ...postIds.map(
              (e) => widget.type == 'title'
                  ? CardWithTitle(postId: e)
                  : CardWithProfileName(
                      postId: e, callback: () => setState(() {})),
            ),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
