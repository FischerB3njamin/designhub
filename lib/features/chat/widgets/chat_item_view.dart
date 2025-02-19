import 'package:designhub/features/chat/models/chat.dart';
import 'package:designhub/features/chat/view/chat_detail_screen.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:designhub/shared/widgets/avatar_circle.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class ChatItemView extends StatelessWidget {
  final Chat chat;
  final ProfileController profileController = ProfileController();
  final Profile senderProfile;
  ChatItemView({
    super.key,
    required this.chat,
    required this.senderProfile,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => CustomBottomSheet.show(
        context,
        ChatDetailScreen(chat: chat, senderProfile: senderProfile),
        1,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Container(
          padding: EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: DesignhubColors.grey300),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              topRight: Radius.circular(6),
              bottomRight: Radius.circular(6),
            ),
          ),
          child: Row(
            children: [
              AvatarCircle(profile: senderProfile, height: 50, width: 50),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(senderProfile.name),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      chat.chatItems.reversed.first.text,
                      style: TextTheme.of(context).bodySmall,
                    )
                  ],
                ),
              ),
              SizedBox(width: 4),
              Text(
                chat.chatItems.reversed.first.date,
                style: TextTheme.of(context).bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
