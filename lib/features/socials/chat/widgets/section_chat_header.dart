import 'package:designhub/features/socials/profile/models/profile.dart';
import 'package:designhub/shared/widgets/avatar_circle.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class SectionChatHeader extends StatelessWidget {
  final Profile senderProfile;

  const SectionChatHeader({super.key, required this.senderProfile});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: DesignhubColors.grey100,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          AvatarCircle(width: 44, height: 44, profile: senderProfile),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              senderProfile.name,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
