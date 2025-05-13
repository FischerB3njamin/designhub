import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String postId;
  String title;
  String description;
  String hashtags;
  List<String> images;
  bool isSos;
  bool isActive;
  int likes;
  String userId;
  DateTime created;

  // search field

  Post({
    required this.postId,
    required this.created,
    required this.title,
    required this.description,
    required this.hashtags,
    required this.images,
    required this.userId,
    required this.isSos,
    required this.isActive,
    this.likes = 0,
  });

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      created: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      postId: map['postId'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      hashtags: map['hashtags'] ?? '',
      images: List<String>.from(map['images'] ?? []),
      userId: map['userId'] ?? '',
      isSos: map['isSos'] ?? false,
      isActive: map['isActive'] ?? true,
      likes: map['likes'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'title': title,
      'description': description,
      'hashtags': hashtags,
      'images': images,
      'userId': userId,
      'isSos': isSos,
      'isActive': isActive,
      'likes': likes,
      'created': created,
      // only for search
      'search':
          '${title.toLowerCase()} ${hashtags.toLowerCase()} ${description.toLowerCase()}'
              .split(' ')
              .toSet()
              .toList(),
    };
  }
}
