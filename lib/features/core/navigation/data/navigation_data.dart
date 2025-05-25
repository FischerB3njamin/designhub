import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/features/core/navigation/models/navigation.dart';

class NavigationData {
  static final List<Navigation> items = [
    Navigation(
      icon: Assets.icons.home,
      label: "Home",
    ),
    Navigation(
      icon: Assets.icons.sos,
      label: "Rescue",
    ),
    Navigation(
      icon: Assets.icons.chat,
      label: "News",
    ),
    Navigation(
      icon: Assets.icons.profile,
      label: "Profile",
    ),
  ];
}
