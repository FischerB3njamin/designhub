import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/search/data/search_repo.dart';

class SearchControllerCustom {
  final SearchRepo repo;

  SearchControllerCustom(this.repo);

  Future<List<Post>> searchPosts(String userId) => repo.searchPosts(userId);
  Future<List<Profile>> searchProfiles(String userId) =>
      repo.searchProfiles(userId);
}
