import 'package:designhub/features/posts/data/post_mock_database.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/models/roll_out_type.dart';
import 'package:designhub/features/profile/models/profile_singleton.dart';
import 'package:designhub/features/rating/view/bs_rating_view.dart';
import 'package:designhub/features/rating/widgets/rating_post_detail_section.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({super.key, this.posts});
  final List<Post>? posts;
  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  PostMockDatabase db = PostMockDatabase();
  late List<Post> posts;
  int index = 0;
  bool notDragged = true;

  @override
  Widget build(BuildContext context) {
    setState(() {
      posts = widget.posts ?? db.getPosts(ProfileSingleton().profile!.userId);
    });

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListWheelScrollView(
        diameterRatio: 0.1,
        itemExtent: 500,
        children: [
          ...posts.map(
            (e) => Draggable(
              onDragStarted: () => setState(() {
                notDragged = false;
              }),
              onDragEnd: (details) => setState(
                () {
                  notDragged = true;

                  if (details.offset.dx < -140) {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => BsRatingView(
                          post: e, rolloutType: RollOutType.dislike),
                    );
                  }
                  if (details.offset.dx > 140) {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) =>
                          BsRatingView(post: e, rolloutType: RollOutType.like),
                    );
                  }
                },
              ),
              feedback: Card(
                child: RatingPostDetailSection(post: e),
              ),
              child: notDragged
                  ? Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RatingPostDetailSection(post: e),
                      ),
                    )
                  : Row(
                      children: [
                        Assets.icons.like.image(
                          width: 100,
                          height: 100,
                          color: DesignhubColors.primary,
                        ),
                        Spacer(),
                        Assets.icons.dislike.image(
                          width: 100,
                          height: 100,
                          color: DesignhubColors.primary,
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
