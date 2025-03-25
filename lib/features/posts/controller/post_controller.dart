import 'package:designhub/features/posts/data/post_mock_db.dart';
import 'package:designhub/features/posts/data/post_repo.dart';
import 'package:designhub/features/posts/models/post.dart';

class PostController {
  PostRepo repo = PostMockDB();

  Future<Post> getPostById(String postId) => repo.getPostById(postId);
  Future<List<Post>> getPosts(String userId) => repo.getPosts(userId);
  Future<List<Post>> getPostsByUsers(List<String> userIds) =>
      repo.getPostsByUsers(userIds);
  void createPost(Post post) => repo.createPost(post);
  Future<String> createPostId() => repo.createPostId();
  Future<List<Post>> getPostsById(Set<String> postIds) =>
      repo.getPostsById(postIds);
  Future<void> deletePost(String postId) => repo.deletePost(postId);
}
