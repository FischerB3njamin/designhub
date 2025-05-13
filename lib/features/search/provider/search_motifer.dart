import 'package:designhub/features/design_sos/widgets/sos_post_card.dart';
import 'package:designhub/features/home/widgets/card_post.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/search/controller/search_controller.dart';
import 'package:designhub/features/search/widgets/profile_search_widget.dart';
import 'package:designhub/features/profile/provider/current_profile_notifier.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class SearchNotifier extends ChangeNotifier {
  final BuildContext context;
  late final ProfileController _profileController;
  late final SearchControllerCustom _searchController;
  late final CurrentProfileNotifier _currentProfileNotifier;
  String selectedTab = 'Post';

  SearchNotifier(this.context) {
    _profileController = context.read<ProfileController>();
    _searchController = context.read<SearchControllerCustom>();
    _currentProfileNotifier = context.read<CurrentProfileNotifier>();
  }

  String query = '';
  List<Post> posts = [];
  List<Post> sos = [];
  List<Profile> profiles = [];

  bool isLoading = false;

  bool get isPerson => selectedTab == 'Person';

  void updateQuery(String newQuery) {
    print(selectedTab);
    query = newQuery;
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
    isLoading = true;
    notifyListeners();

    final results = await _searchController.searchPosts(
        query, false, _currentProfileNotifier.getProfileId());
    posts.addAll(results);

    final profileIds = results.map((post) => post.userId).toSet();
    final newProfiles = await _profileController.getProfilesById(profileIds);
    profiles.addAll(newProfiles);

    isLoading = false;
    notifyListeners();
  }

  Future<void> searchSos() async {
    isLoading = true;
    notifyListeners();

    final results = await _searchController.searchPosts(
        query, true, _currentProfileNotifier.getProfileId());

    sos.addAll(results);
    final profileIds = results.map((post) => post.userId).toSet();
    final newProfiles = await _profileController.getProfilesById(profileIds);
    profiles.addAll(newProfiles);
    isLoading = false;
    notifyListeners();
  }

  Future<void> searchProfiles() async {
    isLoading = true;
    notifyListeners();

    final results = await _searchController.searchProfiles(
        query, _currentProfileNotifier.getProfileId());
    print("result : ${results.length}");
    profiles.addAll(results);

    isLoading = false;
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
      return profiles.firstWhere((profile) => profile.userId == post.userId);
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
