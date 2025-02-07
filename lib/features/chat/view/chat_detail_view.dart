import 'package:designhub/features/chat/data/chat/chat_mock_database.dart';
import 'package:designhub/features/chat/models/chat.dart';
import 'package:designhub/features/chat/models/chat_item.dart';
import 'package:designhub/features/chat/widgets/chat_detail_item.dart';
import 'package:designhub/features/chat/widgets/chat_header.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/profile/models/profile_singleton.dart';
import 'package:designhub/gen/assets.gen.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          top: 60,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: FractionallySizedBox(
          heightFactor: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                    flex: 1,
                    child: ChatHeader(senderProfile: widget.senderProfile)),
                Expanded(
                  flex: 10,
                  child: ListView.builder(
                    reverse: true, // Starts at the bottom
                    itemCount: widget.chat.chatItems.length,
                    itemBuilder: (context, index) {
                      return ChatDetailItem(
                          item: widget.chat.chatItems.reversed.toList()[index],
                          senderProfile: widget.senderProfile);
                    },
                  ),
                ),
                Flexible(
                    child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 44,
                        child: TextField(
                          controller: message,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'Message',
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    IconButton(
                      onPressed: () {
                        // add db
                        ChatMockDatabase db = ChatMockDatabase();
                        int day = DateTime.now().day;
                        int month = DateTime.now().month;
                        String convertedMonth =
                            month < 10 ? "0$month" : "$month";
                        db.addNewMessage(
                          widget.chat,
                          ChatItem(
                              text: message.text,
                              date: "$day.$convertedMonth",
                              userId: ProfileSingleton().profile!.userId),
                        );
                        setState(() {});
                        message.text = "";
                      },
                      icon: Assets.icons.sendMessage.svg(
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
