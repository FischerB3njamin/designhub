import 'package:designhub/features/profile/data/profile.mock.dart';
import 'package:designhub/features/profile/data/profile_repo.dart';
import 'package:designhub/features/profile/models/profile.dart';

class ProfileMockDB extends ProfileRepo {
  static final ProfileMockDB _ = ProfileMockDB._internal();
  ProfileMockDB._internal();
  factory ProfileMockDB() => _;

  List<Profile> data = profiles;

  @override
  Future<void> setCurrentProfile(Profile profile) async {
    currentProfile = profile;
  }

  @override
  Future<Profile> getProfile(String userId) async {
    return Future.delayed(Duration(seconds: 1), () {
      for (var item in data) {
        if (item.userId == userId) return item;
      }
      throw Exception('Profile not found');
    });
  }

  @override
  Future<Profile> createProfile(String name, String userId) async =>
      Future.delayed(Duration(seconds: 3), () {
        Profile newProfile = Profile(name: name, userId: userId);
        data.add(newProfile);
        return newProfile;
      });

  @override
  Future<void> saveLike(Profile profile, String postId) async =>
      data[data.indexOf(profile)].liked!.add(postId);

  @override
  Future<void> removeLike(Profile profile, String postId) async =>
      data[data.indexOf(profile)].liked!.remove(postId);

  @override
  Future<void> removeSavePost(Profile profile, String postId) async =>
      data[data.indexOf(profile)].savedPosts.remove(postId);

  @override
  Future<void> savePost(Profile profile, String postId) async =>
      data[data.indexOf(profile)].savedPosts.add(postId);

  @override
  Future<void> addPost(String postId) async {
    currentProfile!.posts.add(postId);
  }

  @override
  Future<void> logout() async {
    currentProfile = null;
  }

  @override
  Future<List<Profile>> getProfilesById(Set<String> profileIds) async {
    return Future.delayed(Duration(seconds: 2), () {
      return data.where((e) => profileIds.contains(e.userId)).toList();
    });
  }
}
