import 'package:designhub/features/content/comment/data/comments_repo.dart';
import 'package:designhub/features/content/comment/models/comment.dart';
import 'package:designhub/features/content/comment/models/comment_item.dart';

class CommentMockRepo implements CommentsRepo {
  static final CommentMockRepo _ = CommentMockRepo._internal();
  CommentMockRepo._internal();

  factory CommentMockRepo() => _;

  List<Comment> data = [
    Comment(postId: 'po-001'),
    Comment(postId: 'po-002'),
    Comment(postId: 'po-003'),
    Comment(postId: 'po-004'),
  ];

  @override
  Future<void> addComment(String postId, CommentItem comment) async {
    final result = data.where((e) => postId == e.postId);
    if (result.isNotEmpty) {
      result.first.comments.insert(0, comment);
    } else {
      data.add(Comment(postId: postId, comments: [comment]));
    }
  }

  @override
  Future<List<CommentItem>> getComments(String postId) async {
    return Future.delayed(Duration(milliseconds: 100), () {
      final obj = data.where((e) => e.postId == postId).toList();
      if (obj.isNotEmpty) {
        return obj.first.comments;
      }

      return [];
    });
  }

  @override
  Future<void> deleteComment(String postId) {
    return Future.delayed(Duration(milliseconds: 100), () {
      data.removeWhere((e) => e.postId == postId);
    });
  }
}
