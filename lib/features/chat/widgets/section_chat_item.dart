import 'package:designhub/features/chat/provider/chat_item_notifier.dart';
import 'package:designhub/features/chat/widgets/chat_detail_item.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/profile/provider/current_profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionChatItem extends StatelessWidget {
  final Profile senderProfile;

  const SectionChatItem({super.key, required this.senderProfile});

  @override
  Widget build(BuildContext context) {
    final chatItemNotifier = context.watch<ChatItemNotifier>();

    if (chatItemNotifier.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final chatItems = chatItemNotifier.data;
    return ListView.builder(
      reverse: true,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: chatItems.length,
      itemBuilder: (context, index) {
        final item = chatItems[index];
        final isSender =
            context.read<CurrentProfileNotifier>().getProfileId() ==
                item.senderId;

        return ChatDetailItem(
          item: item,
          isSender: isSender,
          senderProfile: senderProfile,
        );
      },
    );
  }
}
