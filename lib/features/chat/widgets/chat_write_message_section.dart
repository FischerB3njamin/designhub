import 'package:designhub/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class ChatWriteMessageSection extends StatelessWidget {
  final TextEditingController messageController;
  final Function handleNewMessage;

  const ChatWriteMessageSection({
    super.key,
    required this.handleNewMessage,
    required this.messageController,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 44,
              child: TextField(
                controller: messageController,
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
            onPressed: () => handleNewMessage(),
            icon: Assets.icons.sendMessage.svg(
              height: 30,
              width: 30,
            ),
          ),
        ],
      ),
    );
  }
}
