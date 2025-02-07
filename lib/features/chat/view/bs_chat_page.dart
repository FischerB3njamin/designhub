import 'package:designhub/features/chat/widgets/chat_view.dart';
import 'package:flutter/material.dart';

class BsChatPage extends StatelessWidget {
  const BsChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 60,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: FractionallySizedBox(
          heightFactor: 1, child: ChatView(isSmallView: false)),
    );
  }
}
