import 'package:designhub/features/posts/models/comment.dart';

class Post {
  String postId;
  String title;
  String description;
  String hashtags;
  List<String> images;

  List<Comment> comments = [];
  int likes = 0;
  String userId;

  Post({
    required this.postId,
    required this.title,
    required this.description,
    required this.hashtags,
    required this.images,
    required this.userId,
  });
}
