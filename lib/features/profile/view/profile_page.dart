import 'package:designhub/features/news/controller/news_controller.dart';
import 'package:designhub/features/news/models/news.dart';
import 'package:designhub/features/news/models/news_type.dart';
import 'package:designhub/features/posts/controller/post_controller.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/profile/widgets/btn_sg_profile_sections.dart';
import 'package:designhub/features/profile/widgets/profile_info.dart';
import 'package:designhub/features/profile/widgets/section_profile_cards.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/shared/widgets/avatar_circle.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final Profile profile;

  const ProfilePage({
    super.key,
    required this.profile,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final profileController = ProfileController();
  final postController = PostController();
  final newsController = NewsController();
  Set<String> tabBar = {"Work", "Info", "Saved"};
  String selectedTab = "Info";
  List<Post>? posts;
  List<Profile>? profiles;
  bool isLoading = true;
  String? errorMessage;
  late Map pages;
  List<News> news = [];

  @override
  void initState() {
    super.initState();
    _loadData();
    loadNews();
  }

  void initPages() {
    pages = {
      'Work': SectionProfilCard(
          profile: widget.profile,
          type: "title",
          posts: posts!,
          profiles: profiles!,
          news: news),
      'Info': ProfileInfo(
        profile: widget.profile,
      ),
      'Saved': SectionProfilCard(
        profile: widget.profile,
        type: "name",
        posts: posts!,
        profiles: profiles!,
        news: news,
      )
    };
    setState(() {});
  }

  void loadNews() async {
    news = await newsController.getNews(widget.profile.userId);
    news = news.where((e) => e.type == NewsType.feedback && !e.read).toList();
  }

  Future<void> _loadData() async {
    try {
      Set<String> allPosts = {};
      allPosts.addAll(widget.profile.savedPosts);
      allPosts.addAll(widget.profile.posts);
      posts = await postController.getPostsById(allPosts);

      Set<String> profileIds = posts!.map((e) {
        return e.userId;
      }).toSet();

      profiles = await profileController.getProfilesById(profileIds);

      if (mounted) {
        initPages();
        setState(() => isLoading = false);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
          errorMessage = 'Fehler beim Laden der Daten';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView(
      children: [
        SizedBox(
          height: 275,
          width: double.infinity,
          child: Stack(
            children: [
              Image.network(
                widget.profile.backgroundImagePath,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Assets.images.noImage.image(
                        height: 180, width: double.infinity, fit: BoxFit.fill),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 53.0),
                  child: AvatarCircle(
                    profile: widget.profile,
                    height: 200,
                    width: 200,
                    allowNavigation: false,
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          widget.profile.name,
          style: TextTheme.of(context)
              .headlineMedium!
              .copyWith(fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16),
        BtnSgProfileSections(
          callback: (value) => setState(() {
            if (value.isNotEmpty) selectedTab = value.first;
          }),
          selectedTab: selectedTab,
          profileId: widget.profile.userId,
        ),
        SizedBox(height: 16),
        pages[selectedTab]
      ],
    );
  }
}
