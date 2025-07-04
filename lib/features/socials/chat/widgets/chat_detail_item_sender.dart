import 'package:designhub/features/socials/chat/models/chat_item.dart';
import 'package:designhub/features/socials/profile/models/profile.dart';
import 'package:designhub/shared/widgets/avatar_circle.dart';
import 'package:designhub/theme/custom_text_styles.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class ChatDetailItemSender extends StatelessWidget {
  final ChatItem item;
  final Profile senderProfile;
  const ChatDetailItemSender({
    super.key,
    required this.item,
    required this.senderProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AvatarCircle(
            width: 50,
            height: 50,
            profile: senderProfile,
          ),
          SizedBox(width: 4),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: DesignhubColors.primary100,
                    border: Border.all(color: DesignhubColors.grey400),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(item.message),
                ),
                Text(
                  item.createdAt.toString(),
                  style: CustomTextStyles.labelSmallColor(
                      context, DesignhubColors.black.withAlpha(200)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
