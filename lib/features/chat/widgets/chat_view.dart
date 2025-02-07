import 'package:designhub/features/chat/data/chat/chat_mock_database.dart';
import 'package:designhub/features/chat/models/chat.dart';
import 'package:designhub/features/chat/view/bs_chat_page.dart';
import 'package:designhub/features/chat/widgets/chat_item_view.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  final bool isSmallView;

  const ChatView({
    super.key,
    required this.isSmallView,
  });

  @override
  Widget build(BuildContext context) {
    ChatMockDatabase db = ChatMockDatabase();
    List<Chat> mockChats = db.getChats();
    List<Chat> chats = isSmallView ? mockChats.sublist(0, 5) : mockChats;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView(
        children: [
          Row(
            children: [
              Text(
                "Chat",
                style: TextTheme.of(context).headlineLarge,
              ),
              Spacer(),
              isSmallView
                  ? OutlinedButton(
                      onPressed: () => showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => BsChatPage()),
                      child: Text(
                        "View all",
                        style: TextTheme.of(context).labelLarge!.copyWith(
                            color: DesignhubColors.primary,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  : IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.close),
                    ),
            ],
          ),
          SizedBox(height: 8),
          ...chats.map(
            (e) => ChatItemView(chat: e),
          ),
        ],
      ),
    );
  }
}
