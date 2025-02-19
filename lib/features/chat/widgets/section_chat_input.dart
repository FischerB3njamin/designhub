import 'package:designhub/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class SectionChatInput extends StatelessWidget {
  final TextEditingController messageController;
  final Function handleNewMessage;

  const SectionChatInput({
    super.key,
    required this.handleNewMessage,
    required this.messageController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
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
    );
  }
}
