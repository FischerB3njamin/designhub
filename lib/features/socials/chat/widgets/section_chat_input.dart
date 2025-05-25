import 'package:designhub/features/socials/chat/provider/chat_item_notifier.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/features/socials/profile/provider/current_profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionChatInput extends StatefulWidget {
  final String chatId;
  const SectionChatInput({super.key, required this.chatId});

  @override
  State<SectionChatInput> createState() => _SectionChatInputState();
}

class _SectionChatInputState extends State<SectionChatInput> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final profile = context.read<CurrentProfileNotifier>().getProfile();
    context.read<ChatItemNotifier>().sendChatItem(text, profile.userId);
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextFormField(
              controller: _messageController,
              maxLines: null,
            ),
          ),
          SizedBox(width: 8),
          IconButton(
            onPressed: _sendMessage,
            icon: Assets.icons.sendMessage.svg(height: 28, width: 28),
          ),
        ],
      ),
    );
  }
}
