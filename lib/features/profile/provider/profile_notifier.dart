import 'dart:io';

import 'package:designhub/features/design_sos/widgets/sos_history.dart';
import 'package:designhub/features/design_sos/widgets/sos_post_card.dart';
import 'package:designhub/features/news/models/news.dart';
import 'package:designhub/features/news/provider/news_notifier.dart';
import 'package:designhub/features/posts/controller/post_controller.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/profile/view/profile_edit_page.dart';
import 'package:designhub/features/profile/widgets/profile_info.dart';
import 'package:designhub/features/profile/widgets/section_profile_cards.dart';
import 'package:designhub/shared/data/image_upload_service.dart';
import 'package:designhub/features/profile/provider/current_profile_notifier.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:designhub/shared/widgets/empty_posts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileNotifier extends ChangeNotifier {
  late Map pages;
  late Profile innerProfile;
  late bool openEdit;
  String? errorMessage;
  List<News> news = [];
  List<Post> posts = [];
  List<Post> savedPost = [];
  List<Post> sosPosts = [];
  bool isLoading = true;
  List<Profile>? profiles;
  String selectedTab = "Info";
  late PostController _postController;
  late NewsNotifier _newsNotifier;
  late ProfileController _profileController;
  late CurrentProfileNotifier _currentProfileNotifier;
  Set<String> tabBar = {"Work", "Info", "Saved", "SOS History"};
  File? headerImageFile;
  File? avatarImageFile;

  ProfileNotifier(BuildContext context) {
    _postController = context.read<PostController>();
    _profileController = context.read<ProfileController>();
    _newsNotifier = context.read<NewsNotifier>();
    _currentProfileNotifier = context.read<CurrentProfileNotifier>();
  }
  init(Profile profile) {
    innerProfile = profile;
    selectedTab = "Info";
    _loadData();
  }

  void initPages() {
    pages = {
      'Work': SectionProfilCard(
        profile: innerProfile,
        posts: posts,
        profiles: profiles!,
        news: news,
      ),
      'Info': ProfileInfo(
        profile: innerProfile,
      ),
      'Saved': SectionProfilCard(
        profile: innerProfile,
        posts: savedPost,
        profiles: profiles!,
        news: news,
      ),
      'SOS': SosHistory()
    };
  }

  Future<void> _loadData() async {
    try {
      openEdit = innerProfile.name.isEmpty;
      news = _newsNotifier.newsList;

      Set<String> allPosts = {};
      allPosts.addAll(innerProfile.savedPosts);
      allPosts.addAll(innerProfile.posts);
      List<Post> result = await _postController.getPostsById(allPosts);

      setPosts(result, innerProfile.posts);
      setSos(result, innerProfile.sosPosts);
      setSavedPosts(result, innerProfile.savedPosts);

      Set<String> profileIds = result.map((e) {
        return e.userId;
      }).toSet();

      profiles = await _profileController.getProfilesById(profileIds);

      initPages();
      isLoading = false;
    } catch (e) {
      isLoading = false;
      errorMessage = 'Error occured, please try again later ';
    }
  }

  void setPosts(List<Post> allPosts, List<String> postIds) =>
      posts = allPosts.where((e) => postIds.contains(e.postId)).toList();
  void setSos(List<Post> allPosts, List<String> postIds) =>
      sosPosts = allPosts.where((e) => postIds.contains(e.postId)).toList();
  void setSavedPosts(List<Post> allPosts, List<String> postIds) =>
      savedPost = allPosts.where((e) => postIds.contains(e.postId)).toList();

  void showEdit(BuildContext context) async {
    final result = await CustomBottomSheet.showAsync(
        context, ProfileEditPage(profile: innerProfile), 0.9);
    if (result) {
      initPages();
      openEdit = false;
    }
  }

  void changePage(Set<String> newSelection) {
    if (newSelection.isEmpty || newSelection.first == selectedTab) return;
    final newTab = newSelection.first;

    if (newTab == 'SOS') {
      loadSosData();
    }
    selectedTab = newTab;
    notifyListeners();
  }

  Future<void> loadSosData() async {
    try {
      sosPosts =
          await _postController.getPostsByUserId(innerProfile.userId, true);
      notifyListeners();
    } catch (e) {
      errorMessage = 'Error occured, please try again later ';
    }
  }

  List<Widget> getPostWidgetsByProfile() {
    if (sosPosts.isEmpty) {
      return [const EmptyPosts()];
    }
    return sosPosts
        .map((post) => SosPostCard(
              profile: innerProfile,
              post: post,
            ))
        .toList();
  }

  Future<void> pickImage(bool isHeader, BuildContext context) async {
    String? path = await ImageUploadService.pickImage(context);
    if (path != null) {
      if (isHeader) {
        headerImageFile = File(path);
      } else {
        avatarImageFile = File(path);
      }
      notifyListeners();
    }
  }

  Future<Profile> updateProfile({
    required Profile currentProfile,
    required String name,
    required String aboutMe,
    required String interests,
  }) async {
    String updatedHeaderUrl = currentProfile.backgroundImagePath;
    String updatedAvatarUrl = currentProfile.avatarImagePath;

    if (headerImageFile != null) {
      updatedHeaderUrl =
          await ImageUploadService.uploadProfileImage(headerImageFile!);
    }

    if (avatarImageFile != null) {
      updatedAvatarUrl =
          await ImageUploadService.uploadProfileImage(avatarImageFile!);
    }

    final updatedProfile = currentProfile.copyWith(
      name: name,
      aboutMe: aboutMe,
      interests: interests,
      backgroundImagePath: updatedHeaderUrl,
      avatarImagePath: updatedAvatarUrl,
    );

    await _profileController.updateProfile(updatedProfile);
    return updatedProfile;
  }

  void clearTempImages() {
    headerImageFile = null;
    avatarImageFile = null;
  }

  void update(profile) {
    innerProfile = profile;
    _currentProfileNotifier.setIsChanged(false);
    initPages();
    notifyListeners();
  }

  void removePost(String postId) {
    posts.removeWhere((post) => post.postId == postId);
    _currentProfileNotifier.removePost(postId);
    initPages();
    notifyListeners();
  }

  void removeSavedPost(String postId) {
    savedPost.removeWhere((post) => post.postId == postId);
    _currentProfileNotifier.removeSavedPost(postId);
    initPages();
  }

  void removeSosPost(String postId) {
    sosPosts.removeWhere((post) => post.postId == postId);
    _currentProfileNotifier.removeSosPost(postId);
  }
}
