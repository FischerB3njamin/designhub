import 'package:designhub/features/chat/models/chat_item.dart';
import 'package:designhub/features/chat/widgets/chat_detail_item.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:flutter/material.dart';

class SectionChatItem extends StatelessWidget {
  final List<ChatItem> chatItems;
  final Profile sender;

  const SectionChatItem({
    super.key,
    required this.chatItems,
    required this.sender,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 10,
      child: ListView.builder(
        reverse: true,
        itemCount: chatItems.length,
        itemBuilder: (context, index) {
          return ChatDetailItem(
            item: chatItems.reversed.toList()[index],
            senderProfile: sender,
          );
        },
      ),
    );
  }
}
