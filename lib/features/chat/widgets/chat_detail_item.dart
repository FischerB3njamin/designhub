import 'package:designhub/features/chat/models/chat_item.dart';
import 'package:designhub/features/chat/widgets/chat_avatar.dart';
import 'package:designhub/features/chat/widgets/message_bubble.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/profile/provider/current_profile_notifier.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatDetailItem extends StatelessWidget {
  final ChatItem item;
  final bool isSender;
  final Profile senderProfile;

  const ChatDetailItem({
    super.key,
    required this.item,
    required this.isSender,
    required this.senderProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment:
              isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isSender) ...[
              ChatAvatar(profile: senderProfile),
              const SizedBox(width: 6),
            ],
            Flexible(child: MessageBubble(item: item, isSender: isSender)),
            if (isSender) ...[
              const SizedBox(width: 6),
              ChatAvatar(
                profile: context.read<CurrentProfileNotifier>().getProfile(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
