import 'package:designhub/features/chat/models/news.dart';
import 'package:designhub/features/chat/models/news_type.dart';
import 'package:designhub/features/posts/data/post_mock_database.dart';
import 'package:designhub/features/posts/view/bs_detail_view.dart';
import 'package:designhub/features/profile/data/profile_mock_database.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/profile/view/bs_profile_view.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class NewsItem extends StatelessWidget {
  final News news;
  final Function callback;
  const NewsItem({
    super.key,
    required this.news,
    required this.callback,
  });

  String buildItemText(Profile profile) {
    switch (news.type) {
      case NewsType.comment:
        return "${profile.name} left a comment on your work!";

      case NewsType.feedback:
        return "${profile.name} gave you feedback!";

      case NewsType.follow:
        return "${profile.name} following your work now!";
    }
  }

  void handleNewsClick(BuildContext context, Profile profile) {
    callback(news);
    handleNavigation(context, profile);
  }

  void handleNavigation(BuildContext context, Profile profile) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          if (NewsType.follow == news.type) {
            return BsProfileView(profileId: profile.userId);
          }
          PostMockDatabase db = PostMockDatabase();

          return BsDetailView(post: db.getPostById(news.postId!));
        });
  }

  @override
  Widget build(BuildContext context) {
    ProfileMockDatabase db = ProfileMockDatabase();
    Profile profile = db.getProfile(news.profilId);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: GestureDetector(
        onTap: () => handleNewsClick(context, profile),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: news.read
                  ? DesignhubColors.transparent
                  : DesignhubColors.primary.withAlpha(50)),
          child: Row(
            children: [
              Container(
                height: 30,
                width: 30,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child:
                    Image.network(profile.avatarImagePath, fit: BoxFit.cover),
              ),
              SizedBox(width: 8),
              Text(
                buildItemText(profile),
                style: TextTheme.of(context).bodySmall,
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  news.date,
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
