import 'package:designhub/features/posts/data/post.mock.dart';
import 'package:designhub/features/posts/data/post_repo.dart';
import 'package:designhub/features/posts/models/post.dart';

class PostMockRepo extends PostRepo {
  static final PostMockRepo _ = PostMockRepo._internal();
  PostMockRepo._internal();

  factory PostMockRepo() => _;

  final List<Post> data = samplePosts;

  @override
  Future<Post> getPostById(String postId) {
    return Future.delayed(Duration(milliseconds: 100), () {
      return data.firstWhere((e) => e.postId == postId);
    });
  }

  @override
  Future<List<Post>> getPosts(
    String userId,
    bool isSos, {
    int page = 0,
    int limit = 3,
  }) {
    return Future.delayed(Duration(milliseconds: 100), () {
      List<Post> filtered =
          data.where((e) => e.userId != userId && e.isSos == isSos).toList();

      if (isSos) {
        filtered = data
            .where((e) => e.userId != userId && e.isSos == isSos && e.isActive)
            .toList();
      }
      var result = _paginate(filtered, page, limit);
      return result;
    });
  }

  @override
  Future<List<Post>> getPostsByUserId(
    String userId,
    bool isSos, {
    int page = 0,
    int limit = 3,
  }) {
    return Future.delayed(Duration(milliseconds: 100), () {
      final filtered =
          data.where((e) => e.userId == userId && e.isSos == isSos).toList();

      var result = _paginate(filtered, page, limit);
      return result;
    });
  }

  @override
  Future<List<Post>> getPostsByUsers(
    List<String> userIds,
    bool isSos, {
    int page = 0,
    int limit = 10,
  }) {
    return Future.delayed(Duration(milliseconds: 100), () {
      final filtered = data.where((e) => userIds.contains(e.userId)).toList();
      return _paginate(filtered, page, limit);
    });
  }

  @override
  Future<String> createPost(Post post) async {
    data.insert(0, post);
    return post.postId;
  }

  @override
  Future<String> createPostId() {
    return Future.delayed(Duration(milliseconds: 100), () {
      return "p-${data.length}";
    });
  }

  @override
  Future<List<Post>> getPostsById(Set<String> postIds) {
    return Future.delayed(Duration(milliseconds: 100), () {
      return data.where((e) => postIds.contains(e.postId)).toList();
    });
  }

  @override
  Future<void> deletePost(String postId) {
    return Future.delayed(Duration(milliseconds: 100), () {
      data.removeWhere((e) => e.postId == postId);
    });
  }

  // --- Helper ---
  List<Post> _paginate(List<Post> posts, int page, int limit) {
    final start = page * limit;
    final end = start + limit;
    if (start >= posts.length) return [];
    return posts.sublist(start, end > posts.length ? posts.length : end);
  }

  @override
  Future<void> update() {
    // TODO: implement update
    throw UnimplementedError();
  }
}
