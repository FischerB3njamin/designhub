import 'package:designhub/features/socials/chat/models/chat_item.dart';
import 'package:designhub/features/socials/profile/provider/current_profile_notifier.dart';
import 'package:designhub/shared/widgets/avatar_circle.dart';
import 'package:designhub/theme/custom_text_styles.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatDetailItemReciever extends StatelessWidget {
  final ChatItem item;
  const ChatDetailItemReciever({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              constraints: BoxConstraints(minHeight: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      border: Border.all(color: DesignhubColors.grey400),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      item.message,
                    ),
                  ),
                  Text(
                    item.createdAt.toString(),
                    style: CustomTextStyles.labelSmallColor(
                        context, DesignhubColors.black.withAlpha(200)),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 4),
          AvatarCircle(
            width: 50,
            height: 50,
            profile: context.read<CurrentProfileNotifier>().getProfile(),
          ),
        ],
      ),
    );
  }
}
