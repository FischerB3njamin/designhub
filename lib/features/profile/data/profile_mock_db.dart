import 'package:designhub/features/profile/data/profile.mock.dart';
import 'package:designhub/features/profile/data/profile_repo.dart';
import 'package:designhub/features/profile/models/profile.dart';

class ProfileMockDB extends ProfileRepo {
  static final ProfileMockDB _ = ProfileMockDB._internal();
  ProfileMockDB._internal();

  factory ProfileMockDB() => _;

  List<Profile> data = profiles;
  @override
  Profile getProfile(String userId) {
    for (var item in data) {
      if (item.userId == userId) return item;
    }
    throw Exception('Profile not found');
  }

  @override
  void createProfile(String name, String userId) =>
      data.add(Profile(name: name, userId: userId));

  @override
  void saveLike(Profile profile, String postId) =>
      data[data.indexOf(profile)].liked!.add(postId);

  @override
  void removeLike(Profile profile, String postId) =>
      data[data.indexOf(profile)].liked!.remove(postId);

  @override
  void removeSavePost(Profile profile, String postId) =>
      data[data.indexOf(profile)].savedPosts.remove(postId);

  @override
  void savePost(Profile profile, String postId) =>
      data[data.indexOf(profile)].savedPosts.add(postId);
}
