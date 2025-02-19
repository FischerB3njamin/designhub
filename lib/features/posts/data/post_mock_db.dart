import 'package:designhub/features/posts/data/post.mock.dart';
import 'package:designhub/features/posts/data/post_repo.dart';
import 'package:designhub/features/posts/models/post.dart';

class PostMockDB extends PostRepo {
  static final PostMockDB _ = PostMockDB._internal();
  PostMockDB._internal();

  factory PostMockDB() => _;
  final List<Post> data = samplePosts;

  @override
  Future<Post> getPostById(String postId) {
    return Future.delayed(Duration(seconds: 1), () {
      return data.firstWhere((e) => e.postId == postId);
    });
  }

  @override
  Future<List<Post>> getPosts(String userId) {
    return Future.delayed(Duration(seconds: 1), () {
      return data.where((e) => e.userId != userId).toList();
    });
  }

  @override
  Future<void> createPost(Post post) async {
    data.insert(0, post);
  }

  @override
  Future<String> createPostId() {
    return Future.delayed(Duration(seconds: 1), () {
      return "p-${data.length}";
    });
  }

  @override
  Future<List<Post>> getPostsById(Set<String> postIds) {
    return Future.delayed(Duration(seconds: 2), () {
      return data.where((e) => postIds.contains(e.postId)).toList();
    });
  }
}
