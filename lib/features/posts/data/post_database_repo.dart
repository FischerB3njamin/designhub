import 'package:designhub/features/posts/models/post.dart';

abstract class PostDatabaseRepo {
  Post getPostById(String postId);
  List<Post> getPosts(String userId);
}
