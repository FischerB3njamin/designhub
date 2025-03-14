import 'package:designhub/features/navigation/view/navigation_page.dart';
import 'package:designhub/features/news/controller/news_controller.dart';
import 'package:designhub/features/news/models/news.dart';
import 'package:designhub/features/news/models/news_type.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/shared/widgets/avatar_circle.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class RatingDone extends StatelessWidget {
  final Post post;
  final controller = ProfileController();
  final newsController = NewsController();
  RatingDone({
    super.key,
    required this.post,
  });

  void _navigation(BuildContext context, Widget page) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Profile>(
      future: controller.getProfile(post.userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error on loading the Profil'));
        } else if (snapshot.hasData) {
          final creator = snapshot.data!;
          newsController.addNews(News(
              profilId: creator.userId,
              date:
                  "${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}",
              type: NewsType.feedback,
              read: false));
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              AvatarCircle(
                width: 250,
                height: 250,
                profile: creator,
              ),
              Text(
                creator.name,
                style: TextTheme.of(context)
                    .headlineLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'Thank you for your Feedback!',
                style: TextTheme.of(context).headlineSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: DesignhubColors.black.withAlpha(150)),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () => _navigation(context, NavigationPage()),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        child: Text(
                          "Done",
                          style: TextTheme.of(context).bodyLarge!.copyWith(
                              color: DesignhubColors.primary,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          _navigation(context, NavigationPage(index: 2)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Text("New Rating"),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        } else {
          return Center(child: Text('Profil nicht gefunden'));
        }
      },
    );
  }
}
