import 'package:designhub/features/socials/chat/provider/chat_notifier.dart';
import 'package:designhub/features/socials/chat/view/chat_news_page.dart';
import 'package:designhub/features/content/design_sos/view/sos_view.dart';
import 'package:designhub/features/discovery/home/view/home_page.dart';
import 'package:designhub/features/content/news/provider/news_notifier.dart';
import 'package:designhub/features/socials/profile/controller/profile_controller.dart';
import 'package:designhub/features/socials/profile/models/profile.dart';
import 'package:designhub/features/socials/profile/provider/profile_notifier.dart';
import 'package:designhub/features/socials/profile/view/profile_page.dart';
import 'package:designhub/features/socials/profile/provider/current_profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationNotifier extends ChangeNotifier {
  int _activeIndex;
  bool _isLoading = true;
  late List<Widget> pages;
  late ProfileController profileController;
  late CurrentProfileNotifier _loginNotifier;
  late ProfileNotifier _profileNotifier;
  Profile? profile;

  NavigationNotifier(int initialIndex, BuildContext context)
      : _activeIndex = initialIndex {
    profileController = context.read<ProfileController>();
    _loginNotifier = context.read<CurrentProfileNotifier>();
    _profileNotifier = context.read<ProfileNotifier>();
    _fetchInitialData(context);
  }

  int get activeIndex => _activeIndex;
  bool get isLoading => _isLoading;
  Widget get activePage => pages[activeIndex];

  set activeIndex(int newIndex) {
    _activeIndex = newIndex;

    notifyListeners();
  }

  Future<void> _fetchInitialData(BuildContext context) async {
    await _loginNotifier.init();
    profile = _loginNotifier.getProfile();
    _profileNotifier.init(profile!);
    if (context.mounted) {
      context.read<NewsNotifier>().init(profile!.userId);
      context.read<ChatNotifier>().init(profile!.userId);
    }

    pages = [
      HomePage(),
      SosView(),
      ChatNewsPage(),
      ProfilePage(),
    ];

    activeIndex = profile!.name.isEmpty ? 3 : 0;
    _isLoading = false;
    notifyListeners();
  }

  void handleIconTap(int index, BuildContext context) {
    activeIndex = index;

    if (activeIndex == 3) {
      final profileNotifier = context.read<ProfileNotifier>();
      final currentProfileNotifier = context.read<CurrentProfileNotifier>();

      profileNotifier.init(
        currentProfileNotifier.getProfile(),
      );
    }
    notifyListeners();
  }

  Future<void> reinit(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    await _fetchInitialData(context);
  }
}
