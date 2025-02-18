import 'package:designhub/features/posts/models/post.dart';

abstract class PostRepo {
  Post getPostById(String postId);
  List<Post> getPosts(String userId);
  void createPost(Post post);
  String createPostId();
}
