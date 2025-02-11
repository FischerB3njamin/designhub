import 'package:designhub/features/chat/widgets/chat_view.dart';
import 'package:designhub/features/news/view/news_view.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: NewsView(
              smallView: true,
            ),
          ),
          Expanded(
            flex: 3,
            child: ChatView(isSmallView: true),
          )
        ],
      ),
    );
  }
}
