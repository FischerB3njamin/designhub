import 'package:designhub/features/content/comment/models/comment_item.dart';

abstract class CommentsRepo {
  Future<void> addComment(String postId, CommentItem comment);
  Future<List<CommentItem>> getComments(String postId);
  Future<void> deleteComment(String postId);
}
