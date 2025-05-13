import 'package:designhub/features/posts/models/post.dart';

abstract class PostRepo {
  Future<Post> getPostById(String postId);

  Future<List<Post>> getPosts(
    String userId,
    bool isSos, {
    int page = 0,
    int limit = 10,
  });

  Future<List<Post>> getPostsByUsers(
    List<String> userIds,
    bool isSos, {
    int page = 0,
    int limit = 10,
  });
  getPostsByUserId(
    String userId,
    bool isSos, {
    int page = 0,
    int limit = 10,
  });

  Future<String> createPost(Post post);

  Future<String> createPostId();

  Future<List<Post>> getPostsById(Set<String> postIds);

  Future<void> deletePost(String postId);

  Future<void> update();
}
