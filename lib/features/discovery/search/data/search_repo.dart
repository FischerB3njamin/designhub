import 'package:designhub/features/content/posts/models/post.dart';
import 'package:designhub/features/socials/profile/models/profile.dart';

abstract class SearchRepo {
  Future<List<Post>> searchPosts(String userId);
  Future<List<Profile>> searchProfiles(String userId);
}
