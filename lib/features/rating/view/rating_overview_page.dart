import 'package:designhub/features/posts/controller/post_controller.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/features/question/models/roll_out_type.dart';
import 'package:designhub/features/rating/view/rating_page.dart';
import 'package:designhub/features/rating/widgets/on_drag_bg.dart';
import 'package:designhub/features/rating/widgets/section_rating_post_detail.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';

class RatingOverviewPage extends StatefulWidget {
  const RatingOverviewPage({super.key, this.posts});
  final List<Post>? posts;
  @override
  State<RatingOverviewPage> createState() => _RatingOverviewPageState();
}

class _RatingOverviewPageState extends State<RatingOverviewPage> {
  final controller = PostController();
  final ProfileController profileController = ProfileController();

  List<Post> posts = [];
  int index = 0;
  bool notDragged = true;
  late Future<List<Post>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _postsFuture = _loadPosts();
  }

  Future<List<Post>> _loadPosts() async {
    if (widget.posts != null) {
      return widget.posts!;
    } else {
      return controller.getPosts(profileController.getCurrentProfile().userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder<List<Post>>(
        future: _postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Fehler beim Laden der Posts'));
          } else if (snapshot.hasData) {
            posts = snapshot.data!;
            return ListWheelScrollView(
              physics: FixedExtentScrollPhysics(),
              onSelectedItemChanged: (value) {},
              diameterRatio: 0.1,
              itemExtent: 550,
              children: [
                ...posts.map(
                  (e) => Draggable(
                    onDragStarted: () => setState(() {
                      notDragged = false;
                    }),
                    onDragEnd: (details) => setState(
                      () {
                        notDragged = true;
                        bool like = details.offset.dx > 140;
                        bool dislike = details.offset.dx < -140;

                        if (like || dislike) {
                          CustomBottomSheet.show(
                            context,
                            RatingPage(
                              post: e,
                              rolloutType:
                                  like ? RollOutType.like : RollOutType.dislike,
                            ),
                            1,
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
                        : OnDragBg(),
                  ),
                ),
              ],
            );
          } else {
            return Center(child: Text('Keine Posts gefunden'));
          }
        },
      ),
    );
  }
}
