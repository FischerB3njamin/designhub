import 'package:designhub/features/socials/chat/widgets/section_chat_header.dart';
import 'package:designhub/features/socials/chat/widgets/section_chat_item.dart';
import 'package:designhub/features/socials/chat/widgets/section_chat_input.dart';
import 'package:designhub/features/socials/profile/models/profile.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class ChatDetailScreen extends StatelessWidget {
  final String chatId;
  final Profile senderProfile;

  const ChatDetailScreen({
    super.key,
    required this.chatId,
    required this.senderProfile,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: DesignhubColors.white,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 60),
              SectionChatHeader(senderProfile: senderProfile),
              const SizedBox(height: 8),
              Expanded(
                child: SectionChatItem(senderProfile: senderProfile),
              ),
              SectionChatInput(chatId: chatId),
            ],
          ),
        ),
      ),
    );
  }
}
