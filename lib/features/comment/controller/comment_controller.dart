import 'package:designhub/features/comment/data/comment_mock_repo.dart';
import 'package:designhub/features/comment/data/comments_repo.dart';
import 'package:designhub/features/comment/models/comment_item.dart';

class CommentController {
  CommentsRepo repo = CommentMockRepo();
  CommentController(this.repo);

  Future<void> addComment(String postId, CommentItem comment) =>
      repo.addComment(postId, comment);

  Future<List<CommentItem>> getComments(String postId) =>
      repo.getComments(postId);

  Future<void> deleteComment(String postId) => repo.deleteComment(postId);
}
