import 'package:cloud_firestore/cloud_firestore.dart';

class CommentItem {
  final String id;
  final String userId;
  final String message;
  final DateTime createdAt;

  CommentItem({
    required this.id,
    required this.userId,
    required this.message,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'message': message,
      'createdAt': createdAt.toUtc(),
    };
  }

  factory CommentItem.fromMap(String id, Map<String, dynamic> map) {
    return CommentItem(
      id: id,
      userId: map['userId'],
      message: map['message'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}
