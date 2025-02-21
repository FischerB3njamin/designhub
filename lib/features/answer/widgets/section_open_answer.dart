import 'package:designhub/features/answer/models/answer_item.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/shared/widgets/avatar_circle.dart';
import 'package:flutter/material.dart';

class SectionOpenAnswer extends StatelessWidget {
  final AnswerItem item;
  final Profile profile;

  const SectionOpenAnswer({
    super.key,
    required this.item,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      AvatarCircle(profile: profile, height: 30, width: 30),
      SizedBox(width: 6),
      Text(item.text)
    ]);
  }
}
