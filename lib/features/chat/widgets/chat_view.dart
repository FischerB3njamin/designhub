import 'package:designhub/features/chat/data/chat_mock_db.dart';
import 'package:designhub/features/chat/models/chat.dart';
import 'package:designhub/features/chat/widgets/chat_item_view.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
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
    ChatMockDB db = ChatMockDB();
    List<Chat> mockChats = db.getChats();
    List<Chat> chats = isSmallView ? mockChats.sublist(0, 5) : mockChats;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 16.0, vertical: isSmallView ? 0 : 60),
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
                      onPressed: () => CustomBottomSheet.show(
                          context, ChatView(isSmallView: false), 1),
                      child: Text(
                        "View all",
                        style: TextTheme.of(context).labelLarge!.copyWith(
                              color: DesignhubColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    )
                  : IconButton(
                      onPressed: () => CustomBottomSheet.close(context),
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
