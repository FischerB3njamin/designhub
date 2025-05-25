import 'package:designhub/features/content/design_sos/widgets/sos_post_card.dart';
import 'package:designhub/features/discovery/home/widgets/card_post.dart';
import 'package:designhub/features/content/posts/models/post.dart';
import 'package:designhub/features/socials/profile/models/profile.dart';
import 'package:designhub/features/discovery/search/controller/search_controller.dart';
import 'package:designhub/features/discovery/search/widgets/profile_search_widget.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class SearchNotifier extends ChangeNotifier {
  final BuildContext context;

  late final SearchControllerCustom _searchController;

  String selectedTab = 'Post';

  SearchNotifier(this.context) {
    _searchController = context.read<SearchControllerCustom>();
  }

  String query = '';
  List<Post> posts = [];
  List<Post> sos = [];
  List<Profile> profiles = [];

  List<Post> allPosts = [];
  List<Post> allSos = [];
  List<Profile> allProfiles = [];

  bool isLoading = false;

  bool get isPerson => selectedTab == 'Person';

  init(String userId) async {
    isLoading = true;
    notifyListeners();

    final postResult = await _searchController.searchPosts(userId);
    allSos = postResult.where((e) => e.isSos == true).toList();
    allPosts = postResult.where((e) => e.isSos == false).toList();
    allProfiles = await _searchController.searchProfiles(userId);

    isLoading = false;
    notifyListeners();
  }

  void updateQuery(String newQuery) {
    query = newQuery.toLowerCase();
    resetSearch();
    switch (selectedTab) {
      case 'SOS':
        searchSos();
        break;
      case 'Post':
        searchPosts();
        break;
      case 'Person':
        searchProfiles();
        break;
    }
  }

  void resetSearch() {
    posts.clear();
    sos.clear();
    profiles.clear();
    notifyListeners();
  }

  Future<void> searchPosts() async {
    posts.clear();

    posts = allPosts
        .where((e) =>
            e.title.toLowerCase().contains(query) ||
            e.hashtags.toLowerCase().contains(query))
        .toList();
    notifyListeners();
  }

  Future<void> searchSos() async {
    sos = [];
    sos = allSos
        .where((e) =>
            e.title.toLowerCase().contains(query) ||
            e.hashtags.toLowerCase().contains(query))
        .toList();
    notifyListeners();
  }

  Future<void> searchProfiles() async {
    profiles =
        allProfiles.where((e) => e.name.toLowerCase().contains(query)).toList();
    notifyListeners();
  }

  bool hasResults() {
    switch (selectedTab) {
      case 'SOS':
        return sos.isNotEmpty;
      case 'Post':
        return posts.isNotEmpty;
      case 'Person':
        return profiles.isNotEmpty;
    }
    return false;
  }

  void changePage(Set<String> newSelection) {
    if (newSelection.isEmpty || newSelection.first == selectedTab) return;
    selectedTab = newSelection.first;
    resetSearch();
    updateQuery(query);
  }

  List<Widget> getWidgets() {
    switch (selectedTab) {
      case 'SOS':
        return createSosWidgets();
      case 'Post':
        return createPostWidgets();
      case 'Person':
        return createPersonWidgets();
    }
    return [];
  }

  Profile? getProfileForPost(Post post) {
    try {
      return allProfiles.firstWhere((profile) => profile.userId == post.userId);
    } catch (_) {
      return null;
    }
  }

  List<Widget> createPostWidgets() {
    return posts
        .map((post) {
          final profile = getProfileForPost(post);
          if (profile == null) return null;
          return SizedBox(
              width: double.infinity,
              height: 560,
              child: CardPost(post: post, profile: profile));
        })
        .whereType<Widget>()
        .toList();
  }

  List<Widget> createSosWidgets() {
    return sos
        .map((post) {
          final profile = getProfileForPost(post);
          if (profile == null) return null;
          return SosPostCard(post: post, profile: profile);
        })
        .whereType<Widget>()
        .toList();
  }

  List<Widget> createPersonWidgets() {
    return profiles
        .map((e) => ProfileSearchWidget(
              profile: e,
            ))
        .toList();
  }
}
