import 'package:designhub/features/chat/controller/chat_controller.dart';
import 'package:designhub/features/chat/models/chat.dart';
import 'package:designhub/features/chat/models/chat_item.dart';
import 'package:designhub/features/chat/widgets/section_chat_header.dart';
import 'package:designhub/features/chat/widgets/section_chat_item.dart';
import 'package:designhub/features/chat/widgets/section_chat_input.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:flutter/material.dart';

class ChatDetailScreen extends StatefulWidget {
  final Chat chat;
  final Profile senderProfile;

  const ChatDetailScreen(
      {super.key, required this.chat, required this.senderProfile});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  TextEditingController messageController = TextEditingController();
  final chatController = ChatController();
  final profileController = ProfileController();

  void handleNewMessage() {
    widget.chat.chatItems.add(createChatItem());
    chatController.addNewMessage(widget.chat);
    setState(() {});
    messageController.clear();
  }

  String createMessageDate() {
    int day = DateTime.now().day;
    int month = DateTime.now().month;
    String convertedMonth = month < 10 ? "0$month" : "$month";
    return "$day.$convertedMonth";
  }

  ChatItem createChatItem() => ChatItem(
        text: messageController.text,
        date: createMessageDate(),
        userId: profileController.getCurrentProfile().userId,
      );

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16, top: 60, bottom: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SectionChatHeader(senderProfile: widget.senderProfile),
          SectionChatItem(
              chatItems: widget.chat.chatItems, sender: widget.senderProfile),
          SectionChatInput(
              handleNewMessage: handleNewMessage,
              messageController: messageController),
        ],
      ),
    );
  }
}
