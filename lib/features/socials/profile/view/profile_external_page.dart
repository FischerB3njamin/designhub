import 'package:cached_network_image/cached_network_image.dart';
import 'package:designhub/features/socials/chat/provider/chat_notifier.dart';
import 'package:designhub/features/socials/follow/widgets/btn_follow.dart';
import 'package:designhub/features/content/posts/controller/post_controller.dart';
import 'package:designhub/features/content/posts/models/post.dart';
import 'package:designhub/features/socials/profile/models/profile.dart';
import 'package:designhub/features/socials/profile/widgets/profile_info.dart';
import 'package:designhub/features/socials/profile/widgets/section_profile_cards.dart';
import 'package:designhub/shared/widgets/avatar_circle.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileExternalPage extends StatefulWidget {
  final Profile profile;
  const ProfileExternalPage({super.key, required this.profile});

  @override
  State<ProfileExternalPage> createState() => _ProfileExternalPageState();
}

class _ProfileExternalPageState extends State<ProfileExternalPage> {
  Map pages = {};
  List<Post> posts = [];
  bool isLoading = true;
  String selectedTab = "Info";
  Set<String> tabBar = {"Work", "Info"};

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  void _loadPosts() async {
    posts = await context
        .read<PostController>()
        .getPostsById(widget.profile.posts.toSet());
    initPages();
  }

  void initPages() {
    setState(() {
      pages = {
        'Work': SectionProfilCard(
          profile: widget.profile,
          posts: posts,
          profiles: [widget.profile],
          news: [],
        ),
        'Info': ProfileInfo(profile: widget.profile)
      };
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          _buildHeader(),
          _buildName(context),
          const SizedBox(height: 16),
          _buildUserActions(context),
          const SizedBox(height: 16),
          _buildSegmentedButton(),
          const SizedBox(height: 16),
          pages[selectedTab],
        ],
      ),
    );
  }

  Widget _buildSegmentedButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SegmentedButton(
        showSelectedIcon: false,
        onSelectionChanged: (newSelection) {
          if (newSelection.isEmpty || newSelection.first == selectedTab) return;
          setState(() {
            selectedTab = newSelection.first;
          });
        },
        emptySelectionAllowed: true,
        selected: {selectedTab},
        segments: [
          ButtonSegment(
            value: "Info",
            label: Text("Info"),
          ),
          ButtonSegment(
            value: "Work",
            label: Text("Work"),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 275,
      width: double.infinity,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: widget.profile.backgroundImagePath,
            placeholder: (context, url) => Container(
              color: DesignhubColors.white,
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
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
    );
  }

  Widget _buildName(BuildContext context) {
    return Text(
      widget.profile.name,
      style: TextTheme.of(context)
          .headlineMedium!
          .copyWith(fontWeight: FontWeight.w500),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildUserActions(BuildContext context) {
    final chatNotifier = context.read<ChatNotifier>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
          child: TextButton(
            style: ButtonStyle(
              minimumSize: WidgetStateProperty.all(const Size(120, 35)),
              backgroundColor: WidgetStateProperty.all(DesignhubColors.primary),
              padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              ),
            ),
            onPressed: () {
              chatNotifier.openChat(context, widget.profile);
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 32),
              child: Text(
                'Get in touch',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: DesignhubColors.white,
                ),
              ),
            ),
          ),
        ),
        BtnFollow(profilId: widget.profile.userId),
      ],
    );
  }
}
