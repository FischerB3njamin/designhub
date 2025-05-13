import 'package:designhub/features/home/widgets/card_post.dart';
import 'package:designhub/features/posts/controller/post_controller.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/shared/provider/base_provider.dart';
import 'package:designhub/features/profile/provider/current_profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeNotifier extends BaseUiProvider {
  late final ProfileController _profileController;
  late final PostController _postController;
  late final CurrentProfileNotifier _loginNotifier;

  List<Post> posts = [];
  List<Profile> profiles = [];

  int activeTab = 1;
  bool? hasFollower;
  int page = 0;
  final int pageSize = 30;

  bool isLoadingMore = false;
  bool hasMore = true;

  HomeNotifier(BuildContext context) {
    _profileController = context.read<ProfileController>();
    _postController = context.read<PostController>();
    _loginNotifier = context.read<CurrentProfileNotifier>();
    _loadPosts();
  }

  void resetUiState() {
    posts.clear();
    profiles.clear();
    page = 0;
    hasMore = true;
    isLoadingMore = false;
    notifyListeners();
  }

  Future<void> _loadPosts() async {
    final profile = _loginNotifier.getProfile();
    await runAsync(() async {
      List<Post> newPosts = [];
      if (activeTab == 1) {
        newPosts = await _postController.getPosts(
          profile.userId,
          false,
          page: page,
          limit: pageSize,
        );
      } else {
        if (_loginNotifier.getCountFollower() != 0) {
          newPosts = await _postController.getPostsByUsers(
              _loginNotifier.getFollowers(), false,
              page: page, limit: pageSize);
        } else {
          newPosts = [];
        }
      }
      if (newPosts.length < pageSize) {
        hasMore = false;
      }

      posts = newPosts;

      final profileIds = posts.map((e) => e.userId).toSet();
      profiles = await _profileController.getProfilesById(profileIds);
      notifyListeners();
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
    _loadPosts();
    notifyListeners();
  }

  List<Widget> getPostWidgets() {
    if (posts.isEmpty || profiles.isEmpty) {
      return [];
    }

    return posts
        .where(
            (post) => profiles.any((profile) => profile.userId == post.userId))
        .map(
          (post) => CardPost(
            post: post,
            profile:
                profiles.firstWhere((profile) => profile.userId == post.userId),
          ),
        )
        .toList();
  }

  Future<void> resetAndLoadData() async {
    resetUiState();
    await _loadPosts();
  }
}
