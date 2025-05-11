import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/search/data/search_repo.dart';

class SearchControllerCustom {
  final SearchRepo repo;

  SearchControllerCustom(this.repo);

  Future<List<Profile>> searchProfiles(String query, String userId) =>
      repo.searchProfiles(query, userId);
  Future<List<Post>> searchPosts(String query, bool isSos, String userId) =>
      repo.searchPosts(query, isSos, userId);
}
