import 'package:designhub/features/follow/controller/follow_controller.dart';
import 'package:designhub/features/home/widgets/card_switcher.dart';
import 'package:designhub/features/home/widgets/section_header.dart';
import 'package:designhub/features/home/widgets/section_switcher.dart';
import 'package:designhub/features/posts/controller/post_controller.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProfileController profileController = ProfileController();
  final followerController = FollowController();
  final PostController postController = PostController();
  List<Post>? posts;
  List<Profile>? profiles;
  bool isLoading = true;
  String? errorMessage;
  int activeTab = 1;
  bool? hasFollower;

  @override
  void initState() {
    super.initState();
    _loadData(true);
  }

  Future<void> _loadData(bool all) async {
    final profile = profileController.getCurrentProfile();

    try {
      posts = all
          ? await postController.getPosts(profile.userId)
          : await postController.getPostsByUsers(
              await followerController.getFollow(profile.userId));

      Set<String> profileIds = posts!.map((e) {
        return e.userId;
      }).toSet();
      profiles = await profileController.getProfilesById(profileIds);
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Fehler beim Laden der Daten';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (errorMessage != null && errorMessage!.isNotEmpty) {
      return Center(
        child: Text(errorMessage!),
      );
    }

    return SafeArea(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SectionHeader(),
        SizedBox(height: 8),
        SectionSwitcher(
          active: activeTab,
          hasFollower: hasFollower ?? false,
          callback: (int index) {
            if (index != activeTab) {
              setState(() {
                activeTab = index;
                isLoading = true;
              });
              _loadData(index == 1);
            }
          },
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 560,
          child: ListWheelScrollView(
            itemExtent: 560,
            diameterRatio: 10,
            useMagnifier: true,
            physics: FixedExtentScrollPhysics(),
            controller: FixedExtentScrollController(),
            children: [
              if (isLoading)
                Center(
                  child: CircularProgressIndicator(),
                ),
              if (!isLoading)
                ...posts!.map(
                  (e) => CardSwitcher(
                    post: e,
                    profile: profiles!
                        .firstWhere((profile) => profile.userId == e.userId),
                  ),
                ),
              if (posts != null && posts!.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Center(
                      child: Text(
                    "You’re not following anyone yet.\n Follow some creators to see their posts here!",
                    style: TextTheme.of(context).headlineSmall,
                    textAlign: TextAlign.center,
                  )),
                )
            ],
          ),
        ),
      ],
    ));
  }
}
