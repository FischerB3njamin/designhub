import 'package:designhub/features/chat/data/chat/chat_mock_database.dart';
import 'package:designhub/features/chat/models/chat.dart';
import 'package:designhub/features/chat/models/chat_item.dart';
import 'package:designhub/features/chat/widgets/chat_header.dart';
import 'package:designhub/features/chat/widgets/chat_item_section.dart';
import 'package:designhub/features/chat/widgets/chat_write_message_section.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/profile/models/profile_singleton.dart';
import 'package:flutter/material.dart';

class ChatDetailView extends StatefulWidget {
  final Chat chat;
  final Profile senderProfile;

  const ChatDetailView(
      {super.key, required this.chat, required this.senderProfile});

  @override
  State<ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends State<ChatDetailView> {
  TextEditingController message = TextEditingController();

  void handleNewMessage() {
    ChatMockDatabase().addNewMessage(widget.chat, createChatItem());
    setState(() {});
    message.clear();
  }

  String createMessageDate() {
    int day = DateTime.now().day;
    int month = DateTime.now().month;
    String convertedMonth = month < 10 ? "0$month" : "$month";
    return "$day.$convertedMonth";
  }

  ChatItem createChatItem() => ChatItem(
        text: message.text,
        date: createMessageDate(),
        userId: ProfileSingleton().profile!.userId,
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ChatHeaderSection(senderProfile: widget.senderProfile),
          ChatItemSection(
              chatItems: widget.chat.chatItems, sender: widget.senderProfile),
          ChatWriteMessageSection(
              handleNewMessage: handleNewMessage, messageController: message),
        ],
      ),
    );
  }
}
