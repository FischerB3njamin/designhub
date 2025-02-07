import 'package:designhub/features/posts/data/post.mock.dart';
import 'package:designhub/features/posts/data/post_database_repo.dart';
import 'package:designhub/features/posts/models/post.dart';

class PostMockDatabase extends PostDatabaseRepo {
  final List<Post> data = samplePosts;

  @override
  Post getPostById(String postId) {
    return data.firstWhere((e) => e.postId == postId);
  }

  @override
  List<Post> getPosts(String userId) {
    return data.where((e) => e.userId != userId).toList();
  }
}
