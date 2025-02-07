import 'package:designhub/features/chat/models/chat_item.dart';
import 'package:designhub/features/chat/widgets/chat_detail_item_reciever.dart';
import 'package:designhub/features/chat/widgets/chat_detail_item_sender.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/profile/models/profile_singleton.dart';
import 'package:flutter/material.dart';

class ChatDetailItem extends StatelessWidget {
  final ChatItem item;
  final Profile senderProfile;

  const ChatDetailItem({
    super.key,
    required this.item,
    required this.senderProfile,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileSingleton().profile!.userId == item.userId
        ? ChatDetailItemReciever(item: item)
        : ChatDetailItemSender(item: item, senderProfile: senderProfile);
  }
}
