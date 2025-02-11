import 'package:designhub/features/navigation/view/navigation_page.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/profile/data/profile_mock_db.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/shared/widgets/avatar_circle.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class RatingDone extends StatelessWidget {
  final Post post;

  const RatingDone({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    ProfileMockDB db = ProfileMockDB();
    Profile creator = db.getProfile(post.userId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AvatarCircle(
          width: 250,
          height: 250,
          imagePath: creator.avatarImagePath,
        ),
        SizedBox(height: 8),
        Text(
          creator.name,
          style: TextTheme.of(context)
              .headlineLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 24),
        Text(
          'Thank you for your Feedback!',
          style: TextTheme.of(context).headlineSmall!.copyWith(
              fontWeight: FontWeight.w600,
              color: DesignhubColors.black.withAlpha(150)),
        ),
        SizedBox(height: 24),
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              OutlinedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => NavigationPage()),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  child: Text(
                    "Done",
                    style: TextTheme.of(context).bodyLarge!.copyWith(
                        color: DesignhubColors.primary,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {},
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
  }
}
