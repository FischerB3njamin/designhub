import 'package:designhub/features/posts/models/post.dart';

abstract class PostRepo {
  Future<Post> getPostById(String postId);
  Future<List<Post>> getPosts(String userId);
  Future<List<Post>> getPostsByUsers(List<String> userIds);
  Future<void> createPost(Post post);
  Future<String> createPostId();
  Future<List<Post>> getPostsById(Set<String> postIds);
  Future<void> deletePost(postId);
}
