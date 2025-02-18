import 'package:designhub/features/comment/data/comments_repo.dart';
import 'package:designhub/features/comment/models/comment.dart';
import 'package:designhub/features/comment/models/comment_item.dart';

class CommentMockDb implements CommentsRepo {
  static final CommentMockDb _ = CommentMockDb._internal();
  CommentMockDb._internal();

  factory CommentMockDb() => _;

  List<Comment> data = [
    Comment(postId: 'po-001'),
    Comment(postId: 'po-002'),
    Comment(postId: 'po-003'),
    Comment(postId: 'po-004'),
  ];

  @override
  void addComment(String postId, CommentItem comment) {
    final result = data.where((e) => postId == e.postId);
    if (result.isNotEmpty) {
      result.first.comments.insert(0, comment);
    } else {
      data.add(Comment(postId: postId, comments: [comment]));
    }
  }

  @override
  List<CommentItem> getComments(String postId) {
    final obj = data.where((e) => e.postId == postId).toList();
    if (obj.isNotEmpty) {
      return obj.first.comments;
    }

    return [];
  }
}
