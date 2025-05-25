import 'package:designhub/features/socials/profile/provider/current_profile_notifier.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BtnFollow extends StatelessWidget {
  final String profilId;
  const BtnFollow({super.key, required this.profilId});

  @override
  Widget build(BuildContext context) {
    final currentProfileNotifier = context.watch<CurrentProfileNotifier>();
    bool isFollowing = currentProfileNotifier.getFollowing(profilId);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
      child: TextButton(
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.all(const Size(120, 35)),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          ),
        ),
        onPressed: () => currentProfileNotifier.toggleFollowing(profilId),
        child: Text(
          isFollowing ? 'Unfollow' : 'Follow',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color:
                isFollowing ? DesignhubColors.black : DesignhubColors.primary,
          ),
        ),
      ),
    );
  }
}
