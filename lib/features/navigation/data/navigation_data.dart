import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/features/navigation/models/navigation.dart';

class NavigationData {
  static final List<Navigation> items = [
    Navigation(
      icon: Assets.icons.home,
      label: "Home",
    ),
    Navigation(
      icon: Assets.icons.chat,
      label: "Chat",
    ),
    Navigation(
      icon: Assets.icons.rating,
      label: "Rating",
    ),
    Navigation(
      icon: Assets.icons.profile,
      label: "Profile",
    ),
  ];
}
