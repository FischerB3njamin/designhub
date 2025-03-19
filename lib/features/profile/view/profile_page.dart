import 'package:designhub/features/news/controller/news_controller.dart';
import 'package:designhub/features/news/models/news.dart';
import 'package:designhub/features/news/models/news_type.dart';
import 'package:designhub/features/posts/controller/post_controller.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/profile/view/profile_edit_page.dart';
import 'package:designhub/features/profile/widgets/btn_sg_profile_sections.dart';
import 'package:designhub/features/profile/widgets/profile_info.dart';
import 'package:designhub/features/profile/widgets/section_profile_cards.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
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
  late Map pages;
  late Profile innerProfile;
  List<Post>? posts;
  String? errorMessage;
  List<News> news = [];
  bool isLoading = true;
  List<Profile>? profiles;
  String selectedTab = "Info";
  final postController = PostController();
  final newsController = NewsController();
  final profileController = ProfileController();
  Set<String> tabBar = {"Work", "Info", "Saved"};

  @override
  void initState() {
    super.initState();
    innerProfile = widget.profile;
    _loadData();
  }

  void initPages() {
    pages = {
      'Work': SectionProfilCard(
          profile: innerProfile,
          type: "title",
          posts: posts!,
          profiles: profiles!,
          news: news,
          callback: () => _loadData()),
      'Info': ProfileInfo(
        profile: innerProfile,
      ),
      'Saved': SectionProfilCard(
          profile: innerProfile,
          type: "name",
          posts: posts!,
          profiles: profiles!,
          news: news,
          callback: () {})
    };
    setState(() {});
  }

  void loadNews() async {
    news = await newsController.getNews(innerProfile.userId);
    news = news.where((e) => e.type == NewsType.feedback && !e.read).toList();
  }

  Future<void> _loadData() async {
    loadNews();
    try {
      Set<String> allPosts = {};
      allPosts.addAll(innerProfile.savedPosts);
      allPosts.addAll(innerProfile.posts);
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
                innerProfile.backgroundImagePath,
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
                    profile: innerProfile,
                    height: 200,
                    width: 200,
                    allowNavigation: false,
                  ),
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: IconButton(
                  onPressed: () async {
                    final result = await CustomBottomSheet.showAsync(
                        context, ProfileEditPage(profile: innerProfile), 0.9);
                    if (result) {
                      initPages();
                      setState(() {
                        innerProfile = profileController.getCurrentProfile();
                      });
                    }
                  },
                  icon: Icon(Icons.edit),
                ),
              ),
            ],
          ),
        ),
        Text(
          innerProfile.name,
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
          profileId: innerProfile.userId,
        ),
        SizedBox(height: 16),
        pages[selectedTab]
      ],
    );
  }
}
