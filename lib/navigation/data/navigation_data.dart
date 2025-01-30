import 'package:designhub/navigation/models/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationData {
  static final List<Navigation> items = [
    Navigation(
      iconData: Icons.home_outlined,
      label: "Home",
    ),
    Navigation(
      iconData: CupertinoIcons.chat_bubble,
      label: "Chat",
    ),
    Navigation(
      iconData: CupertinoIcons.square_pencil,
      label: "Rating",
    ),
    Navigation(
      iconData: CupertinoIcons.person_fill,
      label: "Profile",
    ),
  ];
}
