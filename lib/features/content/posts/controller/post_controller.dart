import 'package:designhub/features/content/posts/data/post_repo.dart';
import 'package:designhub/features/content/posts/models/post.dart';

class PostController {
  final PostRepo repo;

  PostController(this.repo);

  Future<Post> getPostById(String postId) => repo.getPostById(postId);

  Future<List<Post>> getPosts(String userId, bool isSos,
      {int page = 0, int limit = 10}) {
    return repo.getPosts(userId, isSos, page: page, limit: limit);
  }

  Future<List<Post>> getPostsByUsers(
    List<String> userIds,
    bool isSos, {
    int page = 0,
    int limit = 10,
  }) {
    return repo.getPostsByUsers(userIds, isSos, page: page, limit: limit);
  }

  Future<List<Post>> getPostsByUserId(
    String userId,
    bool isSos, {
    int page = 0,
    int limit = 10,
  }) {
    return repo.getPostsByUserId(userId, isSos, page: page, limit: limit);
  }

  Future<String> createPost(Post post) => repo.createPost(post);

  Future<String> createPostId() => repo.createPostId();

  Future<List<Post>> getPostsById(Set<String> postIds) =>
      repo.getPostsById(postIds);

  Future<void> deletePost(String postId) => repo.deletePost(postId);
}
