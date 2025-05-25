import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:designhub/features/content/comment/data/comments_repo.dart';
import 'package:designhub/features/content/comment/models/comment_item.dart';

class CommentFirebaseRepo implements CommentsRepo {
  final _collection = FirebaseFirestore.instance.collection('posts');

  @override
  Future<void> addComment(String postId, CommentItem comment) async {
    try {
      await _collection.doc(postId).collection('comments').add(comment.toMap());
    } catch (e) {
      throw Exception('Failed to add comment');
    }
  }

  @override
  Future<List<CommentItem>> getComments(String postId) async {
    final snapshot = await _collection
        .doc(postId)
        .collection('comments')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => CommentItem.fromMap(doc.id, doc.data()))
        .toList();
  }

  @override
  Future<void> deleteComment(String postId) async {
    final snapshot = await _collection.doc(postId).collection('comments').get();

    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}
