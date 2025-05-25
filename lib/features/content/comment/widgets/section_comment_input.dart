import 'package:designhub/features/content/comment/provider/comment_notifier.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionCommentInput extends StatelessWidget {
  const SectionCommentInput({super.key});

  @override
  Widget build(BuildContext context) {
    final commentNotifier = context.watch<CommentNotifier>();

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        top: 8,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: commentNotifier.messageController,
              onChanged: commentNotifier.updateMessage,
              maxLines: null,
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: commentNotifier.messageText.trim().isEmpty
                ? null
                : commentNotifier.saveComment,
            icon: Assets.icons.sendMessage.svg(height: 30, width: 30),
          ),
        ],
      ),
    );
  }
}
