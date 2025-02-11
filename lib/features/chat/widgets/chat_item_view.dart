import 'package:designhub/features/chat/models/chat.dart';
import 'package:designhub/features/chat/view/chat_detail_view.dart';
import 'package:designhub/features/profile/data/profile_mock_database.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/profile/models/profile_singleton.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:designhub/shared/widgets/avatar_big_circle.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class ChatItemView extends StatelessWidget {
  final Chat chat;

  const ChatItemView({
    super.key,
    required this.chat,
  });

  Profile getProfileFromParticipants() {
    ProfileMockDatabase db = ProfileMockDatabase();
    for (final userId in chat.participants) {
      if (ProfileSingleton().profile!.userId != userId) {
        return db.getProfile(userId);
      }
    }
    throw Exception('No participants found');
  }

  @override
  Widget build(BuildContext context) {
    Profile senderProfile = getProfileFromParticipants();
    return GestureDetector(
      onTap: () => CustomBottomSheet.show(
        context,
        ChatDetailView(chat: chat, senderProfile: senderProfile),
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
              AvatarBigCircle(
                  imagePath: senderProfile.avatarImagePath,
                  height: 50,
                  width: 50),
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
