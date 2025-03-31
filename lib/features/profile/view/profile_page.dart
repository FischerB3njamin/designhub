import 'package:designhub/features/chat/controller/chat_controller.dart';
import 'package:designhub/features/chat/models/chat.dart';
import 'package:designhub/features/chat/view/chat_detail_screen.dart';
import 'package:designhub/features/follow/widgets/btn_follow.dart';
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
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final Profile profile;
  final bool initialOpenEdit;

  const ProfilePage({
    super.key,
    required this.profile,
    this.initialOpenEdit = false,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Map pages;
  late Profile innerProfile;
  List<Post>? posts;
  late bool openEdit;
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

    openEdit = widget.initialOpenEdit;
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

  void showEdit() async {
    final result = await CustomBottomSheet.showAsync(
        context, ProfileEditPage(profile: innerProfile), 0.9);
    if (result) {
      initPages();
      innerProfile = profileController.getCurrentProfile();
      openEdit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    // Use WidgetsBinding to schedule `showEdit()` to run after the build phase
    if (openEdit) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          openEdit = false;
        });
        showEdit();
      });
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
              if (profileController.getCurrentProfile() == innerProfile)
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
        SizedBox(height: 4),
        if (profileController.getCurrentProfile() != innerProfile)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
                child: TextButton(
                  style: ButtonStyle(
                      minimumSize: WidgetStateProperty.all(Size(80, 30)),
                      backgroundColor:
                          WidgetStateProperty.all(DesignhubColors.white)),
                  onPressed: () async {
                    Chat? chat = await ChatController().getChatByParticipants(
                      ProfileController().getCurrentProfile().userId,
                      widget.profile.userId,
                    );
                    chat ??= Chat(
                      chatItems: [],
                      participants: [
                        ProfileController().getCurrentProfile().userId,
                        widget.profile.userId,
                      ],
                    );
                    if (mounted) {
                      CustomBottomSheet.show(
                          context,
                          ChatDetailScreen(
                            chat: chat,
                            senderProfile: widget.profile,
                          ),
                          1);
                    }
                  },
                  child: Text(
                    'Message',
                    style: TextStyle(
                      color: DesignhubColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              BtnFollow(
                profilId: innerProfile.userId,
              ),
            ],
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
