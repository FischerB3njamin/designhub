import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/shared/widgets/avatar_circle.dart';
import 'package:flutter/material.dart';

class ChatAvatar extends StatelessWidget {
  final Profile profile;

  const ChatAvatar({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return AvatarCircle(width: 36, height: 36, profile: profile);
  }
}
