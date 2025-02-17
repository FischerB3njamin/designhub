import 'package:designhub/features/comment/models/comment_item.dart';

abstract class CommentsRepo {
  void addComment(String postId, CommentItem comment);
  List<CommentItem> getComments(String postId);
}
