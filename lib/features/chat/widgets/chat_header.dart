import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/shared/widgets/avatar_big_circle.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class ChatHeader extends StatelessWidget {
  final Profile senderProfile;

  const ChatHeader({
    super.key,
    required this.senderProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        padding: EdgeInsets.only(right: 2),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: DesignhubColors.grey300),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          children: [
            AvatarBigCircle(
              width: 50,
              height: 50,
              imagePath: senderProfile.avatarImagePath,
            ),
            SizedBox(width: 8),
            Text(
              senderProfile.name,
              style: TextTheme.of(context)
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            Spacer(),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.close),
            ),
          ],
        ),
      ),
    );
  }
}
