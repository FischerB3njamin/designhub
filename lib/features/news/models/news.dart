import 'package:designhub/features/news/models/news_type.dart';

class News {
  String? id;
  String? postId;
  String profilId;
  String creatorId;
  String date;
  bool read;
  NewsType type;

  News({
    this.id,
    this.postId,
    required this.profilId,
    required this.creatorId,
    required this.date,
    required this.type,
    required this.read,
  });

  // Convert Firestore map to News instance
  factory News.fromMap(Map<String, dynamic> map, String docId) {
    return News(
      id: docId,
      postId: map['postId'],
      profilId: map['profilId'],
      creatorId: map['creatorId'],
      date: map['date'],
      type: NewsType.values.byName(map['type']),
      read: map['read'],
    );
  }

  // Convert News instance to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'profilId': profilId,
      'creatorId': creatorId,
      'date': date,
      'type': type.name,
      'read': read,
    };
  }
}
