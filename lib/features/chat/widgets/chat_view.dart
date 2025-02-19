import 'package:designhub/features/chat/models/chat.dart';
import 'package:designhub/features/chat/widgets/chat_item_view.dart';
import 'package:designhub/features/profile/data/profile.mock.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  final bool isSmallView;
  final List<Chat> chats;
  final List<Profile> profiles;
  final Profile currentUser;

  const ChatView({
    super.key,
    required this.isSmallView,
    required this.chats,
    required this.profiles,
    required this.currentUser,
  });

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  Profile getSenderProfile(Chat chat) {
    String sender =
        chat.participants.firstWhere((e) => widget.currentUser.userId != e);

    return profiles.firstWhere((e) => e.userId == sender);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 16.0, vertical: widget.isSmallView ? 0 : 60),
      child: ListView(
        children: [
          Row(
            children: [
              Text(
                "Chat",
                style: TextTheme.of(context).headlineLarge,
              ),
              Spacer(),
              widget.isSmallView
                  ? OutlinedButton(
                      onPressed: () => CustomBottomSheet.show(
                          context,
                          ChatView(
                            isSmallView: false,
                            chats: widget.chats,
                            profiles: widget.profiles,
                            currentUser: widget.currentUser,
                          ),
                          1),
                      child: Text(
                        "View all",
                        style: TextTheme.of(context).labelLarge!.copyWith(
                              color: DesignhubColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    )
                  : IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close),
                    ),
            ],
          ),
          SizedBox(height: 8),
          ...widget.chats.map(
            (e) => ChatItemView(chat: e, senderProfile: getSenderProfile(e)),
          ),
        ],
      ),
    );
  }
}
