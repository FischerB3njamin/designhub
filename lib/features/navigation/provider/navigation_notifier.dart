import 'package:designhub/features/chat/provider/chat_notifier.dart';
import 'package:designhub/features/chat/view/chat_news_page.dart';
import 'package:designhub/features/design_sos/views/sos_view.dart';
import 'package:designhub/features/home/view/home_page.dart';
import 'package:designhub/features/news/provider/news_notifier.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/profile/provider/profile_notifier.dart';
import 'package:designhub/features/profile/view/profile_page.dart';
import 'package:designhub/features/profile/provider/current_profile_notifier.dart';
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
