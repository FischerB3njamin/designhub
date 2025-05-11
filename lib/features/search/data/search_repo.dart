import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/profile/models/profile.dart';

abstract class SearchRepo {
  Future<List<Post>> searchPosts(String query, bool isSos, String userId);
  Future<List<Profile>> searchProfiles(String query, String userId);
}
