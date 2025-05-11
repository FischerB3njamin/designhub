import 'package:designhub/features/chat/models/chat.dart';
import 'package:designhub/features/chat/provider/chat_item_notifier.dart';
import 'package:designhub/features/chat/provider/chat_notifier.dart';
import 'package:designhub/features/chat/view/chat_detail_screen.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/profile/provider/current_profile_notifier.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:designhub/shared/widgets/avatar_circle.dart';
import 'package:designhub/theme/custom_text_styles.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatItemView extends StatelessWidget {
  final Chat chat;
  final Profile senderProfile;
  final bool isUnread;

  const ChatItemView({
    super.key,
    required this.chat,
    required this.senderProfile,
    required this.isUnread,
  });

  @override
  Widget build(BuildContext context) {
    final chatNotifier = context.read<ChatNotifier>();
    final loginNotifier = context.read<CurrentProfileNotifier>();
    final chatItemNotifier = context.read<ChatItemNotifier>();

    return GestureDetector(
      onTap: () async {
        chatNotifier.markChatAsRead(chat);

        if (context.mounted) {
          chatItemNotifier.init(chat);
          CustomBottomSheet.show(
            context,
            ChatDetailScreen(chatId: chat.id, senderProfile: senderProfile),
            1,
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: _buildChatItemContainer(context, chatNotifier, loginNotifier),
      ),
    );
  }

  Widget _buildChatItemContainer(BuildContext context,
      ChatNotifier chatNotifier, CurrentProfileNotifier loginNotifier) {
    return Container(
      padding: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        border: Border.all(
            width: 1,
            color:
                chat.unread && chat.lastSenderId != loginNotifier.getProfileId()
                    ? DesignhubColors.primary
                    : DesignhubColors.grey300),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
          topRight: Radius.circular(6),
          bottomRight: Radius.circular(6),
        ),
      ),
      child: Row(
        children: [
          _buildAvatarCircle(),
          const SizedBox(width: 8),
          _buildChatDetails(context),
          const SizedBox(width: 4),
          _buildTimestamp(chatNotifier, context),
        ],
      ),
    );
  }

  Widget _buildAvatarCircle() {
    return AvatarCircle(profile: senderProfile, height: 50, width: 50);
  }

  Widget _buildChatDetails(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSenderName(context),
          _buildLastMessage(context),
        ],
      ),
    );
  }

  Widget _buildSenderName(BuildContext context) {
    return Text(senderProfile.name,
        style: CustomTextStyles.bodyLargeColorBold(
            context, DesignhubColors.black, FontWeight.normal));
  }

  Widget _buildLastMessage(BuildContext context) {
    return Text(
      overflow: TextOverflow.ellipsis,
      chat.lastMessage ?? '',
      style: CustomTextStyles.bodyMedium(context),
    );
  }

  Widget _buildTimestamp(ChatNotifier chatNotifier, BuildContext context) {
    return Text(
      chatNotifier.formatChatTimestamp(chat.updatedAt),
      style: CustomTextStyles.bodySmall(context),
    );
  }
}
