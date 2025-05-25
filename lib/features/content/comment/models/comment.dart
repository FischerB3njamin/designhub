import 'package:designhub/features/content/comment/models/comment_item.dart';

class Comment {
  final List<CommentItem> comments;
  String postId;

  Comment({
    required this.postId,
    List<CommentItem>? comments,
  }) : comments = comments ?? [];
}
