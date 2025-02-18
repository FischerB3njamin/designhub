import 'package:designhub/features/chat/models/chat_item.dart';
import 'package:designhub/features/chat/widgets/chat_detail_item_reciever.dart';
import 'package:designhub/features/chat/widgets/chat_detail_item_sender.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:flutter/material.dart';

class ChatDetailItem extends StatelessWidget {
  final ChatItem item;
  final Profile senderProfile;
  final ProfileController profileController = ProfileController();

  ChatDetailItem({
    super.key,
    required this.item,
    required this.senderProfile,
  });

  @override
  Widget build(BuildContext context) {
    return profileController.getCurrentProfile().userId == item.userId
        ? ChatDetailItemReciever(item: item)
        : ChatDetailItemSender(item: item, senderProfile: senderProfile);
  }
}
