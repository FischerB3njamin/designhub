import 'package:designhub/features/news/models/news.dart';
import 'package:designhub/features/news/models/news_type.dart';
import 'package:designhub/features/posts/controller/post_controller.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/view/post_detail_view.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/profile/view/profile_page.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:designhub/shared/widgets/avatar_circle.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class NewsItem extends StatefulWidget {
  final News news;
  final Function callback;
  final Profile profile;

  const NewsItem({
    super.key,
    required this.news,
    required this.callback,
    required this.profile,
  });

  @override
  State<NewsItem> createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  final postController = PostController();

  String buildItemText(Profile profile) {
    switch (widget.news.type) {
      case NewsType.comment:
        return "${profile.name} left a comment on your work!";

      case NewsType.feedback:
        return "${profile.name} gave you feedback!";

      case NewsType.follow:
        return "${profile.name} following your work now!";
    }
  }

  void handleNewsClick(BuildContext context, Profile profile) {
    widget.callback(widget.news);
    handleNavigation(context, profile);
  }

  void handleNavigation(BuildContext context, Profile profile) async {
    if (widget.news.postId != null) {
      Post post = await postController.getPostById(widget.news.postId!);
      if (mounted) {
        navigation(profile, post);
      }
    }
  }

  void navigation(profile, post) {
    CustomBottomSheet.show(
        context,
        NewsType.follow == widget.news.type
            ? ProfilePage(profile: profile)
            : PostDetailView(
                post: post,
                profile: profile,
              ),
        0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: GestureDetector(
        onTap: () => handleNewsClick(context, widget.profile),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: widget.news.read
                  ? DesignhubColors.transparent
                  : DesignhubColors.primary.withAlpha(50)),
          child: Row(
            children: [
              AvatarCircle(profile: widget.profile, height: 30, width: 30),
              SizedBox(width: 8),
              Text(
                buildItemText(widget.profile),
                style: TextTheme.of(context).bodySmall,
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  widget.news.date,
                  style: TextTheme.of(context).bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
