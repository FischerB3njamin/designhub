import 'package:designhub/features/posts/models/comment.dart';
import 'package:designhub/features/posts/view/new_post_page.dart';

class Post {
  String postId;
  String title;
  String description;
  String hashtags;
  List<String> images;
  List<Question> questions;

  List<Comment> comments = [];
  int likes = 0;
  String creatorName;
  String creatorImage;
  String userId;

  Post({
    required this.postId,
    required this.title,
    required this.description,
    required this.hashtags,
    required this.images,
    required this.questions,
    required this.creatorName,
    required this.creatorImage,
    required this.userId,
  });
}
