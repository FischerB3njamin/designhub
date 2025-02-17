import 'package:designhub/features/comment/models/comment_item.dart';
import 'package:designhub/shared/widgets/avatar_circle.dart';
import 'package:flutter/material.dart';

class CommentDetail extends StatelessWidget {
  final CommentItem comment;
  const CommentDetail({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 2,
              child: AvatarCircle(
                  profilId: comment.profilId, height: 40, width: 40)),
          Expanded(
            flex: 12,
            child: Text(
              comment.text,
              style: TextTheme.of(context).bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
