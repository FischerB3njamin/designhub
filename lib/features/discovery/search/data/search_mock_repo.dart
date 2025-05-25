import 'package:designhub/features/content/posts/data/post.mock.dart';
import 'package:designhub/features/content/posts/models/post.dart';
import 'package:designhub/features/socials/profile/data/profile.mock.dart';
import 'package:designhub/features/socials/profile/models/profile.dart';
import 'package:designhub/features/discovery/search/data/search_repo.dart';

class SearchMockRepo extends SearchRepo {
  static final SearchMockRepo _ = SearchMockRepo._internal();
  SearchMockRepo._internal();

  factory SearchMockRepo() => _;

  final List<Post> postData = samplePosts;
  final List<Profile> profiledata = profiles;

  @override
  Future<List<Post>> searchPosts(String userId) async {
    return Future.delayed(Duration(microseconds: 100), () {
      return postData;
    });
  }

  @override
  Future<List<Profile>> searchProfiles(String userId) async {
    return Future.delayed(Duration(microseconds: 100), () => profiledata);
  }
}
