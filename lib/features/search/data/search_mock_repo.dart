import 'package:designhub/features/posts/data/post.mock.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/profile/data/profile.mock.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/search/data/search_repo.dart';

class SearchMockRepo extends SearchRepo {
  static final SearchMockRepo _ = SearchMockRepo._internal();
  SearchMockRepo._internal();

  factory SearchMockRepo() => _;

  final List<Post> postData = samplePosts;
  final List<Profile> profiledata = profiles;

  @override
  Future<List<Post>> searchPosts(
      String query, bool isSos, String userId) async {
    return Future.delayed(Duration(microseconds: 100), () {
      return postData
          .where((post) =>
              post.title.contains(query) ||
              post.description.contains(query) ||
              post.hashtags.contains(query))
          .toList();
    });
  }

  @override
  Future<List<Profile>> searchProfiles(String query, String userId) async {
    return Future.delayed(
        Duration(microseconds: 100),
        () => profiledata
            .where((profile) => profile.name.contains(query))
            .toList());
  }
}
