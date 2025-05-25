import 'package:designhub/features/content/design_sos/widgets/sos_post_card.dart';
import 'package:designhub/features/content/posts/controller/post_controller.dart';
import 'package:designhub/features/content/posts/models/post.dart';
import 'package:designhub/features/socials/profile/controller/profile_controller.dart';
import 'package:designhub/features/socials/profile/models/profile.dart';
import 'package:designhub/shared/provider/base_provider.dart';
import 'package:designhub/features/socials/profile/provider/current_profile_notifier.dart';
import 'package:designhub/shared/widgets/empty_posts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DesignSosNotifier extends BaseUiProvider {
  late final PostController _postController;
  late final ProfileController _profileController;
  late final CurrentProfileNotifier _loginNotifier;

  bool isFollowing = false;
  List<Post> sosData = [];
  List<Profile> profiles = [];

  int page = 0;
  int activeTab = 1;
  bool? hasFollower;
  final int pageSize = 50;

  bool isLoadingMore = false;
  bool hasMore = true;

  DesignSosNotifier(BuildContext context) {
    _loginNotifier = context.read<CurrentProfileNotifier>();
    _postController = context.read<PostController>();
    _profileController = context.read<ProfileController>();
  }

  Future<void> loadInitialData() async {
    resetUiState();
    page = 0;
    hasMore = true;
    sosData.clear();
    profiles.clear();
    await _loadPosts();
  }

  Future<void> _loadPosts() async {
    final profile = _loginNotifier.getProfile();

    await runAsync(() async {
      List<Post> newPosts = [];

      if (activeTab == 1) {
        newPosts = await _postController.getPosts(profile.userId, true,
            page: page, limit: pageSize);
      } else {
        newPosts = await _postController.getPostsByUsers(
            _loginNotifier.getFollowers(), true,
            page: page, limit: pageSize);
      }

      if (newPosts.length < pageSize) {
        hasMore = false;
      }

      sosData = newPosts;
      final profileIds = sosData.map((e) => e.userId).toSet();
      profiles = await _profileController.getProfilesById(profileIds);

      page++;
    });
  }

  Future<void> loadMore() async {
    if (isLoadingMore || isLoading || !hasMore) return;
    isLoadingMore = true;
    notifyListeners();

    await _loadPosts();

    isLoadingMore = false;
    notifyListeners();
  }

  void handleSectionSwitch(int index) {
    if (activeTab == index) return;

    activeTab = index;
    loadInitialData();
    notifyListeners();
  }

  List<Widget> getPostWidgets(BuildContext context) {
    if (sosData.isEmpty || profiles.isEmpty) {
      return [EmptyPosts()];
    }
    return sosData
        .where(
            (post) => profiles.any((profile) => profile.userId == post.userId))
        .map((post) {
      final profile =
          profiles.firstWhere((profile) => profile.userId == post.userId);
      return SosPostCard(
        profile: profile,
        post: post,
      );
    }).toList();
  }

  closePost(Post post) {
    sosData.remove(post);
    notifyListeners();
  }
}
