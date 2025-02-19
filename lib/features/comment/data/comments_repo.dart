import 'package:designhub/features/comment/models/comment_item.dart';

abstract class CommentsRepo {
  Future<void> addComment(String postId, CommentItem comment);
  Future<List<CommentItem>> getComments(String postId);
}
