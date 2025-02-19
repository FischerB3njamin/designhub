import 'package:designhub/features/home/widgets/card_switcher.dart';
import 'package:designhub/features/home/widgets/section_header.dart';
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

  final PostController postController = PostController();
  List<Post>? posts;
  List<Profile>? profiles;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final profile = profileController.getCurrentProfile();
      posts = await postController.getPosts(profile.userId);
      // getall profiles for this posts

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
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

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
        SizedBox(
          height: 580,
          child: ListWheelScrollView(
            itemExtent: 550,
            diameterRatio: 10,
            physics: FixedExtentScrollPhysics(),
            controller: FixedExtentScrollController(),
            children: posts!
                .map((e) => CardSwitcher(
                    post: e,
                    profile: profiles!
                        .firstWhere((profile) => profile.userId == e.userId)))
                .toList(),
          ),
        ),
      ],
    ));
  }
}
