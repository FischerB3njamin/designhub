import 'package:designhub/features/profile/models/profile.dart';

abstract class ProfileRepo {
  late Profile? currentProfile;
  Future<bool> setCurrentProfile(String userId);
  Future<Profile> getProfile(String userId);
  Future<Profile> createProfile(String name, String userId);
  Future<void> saveLike(Profile profile, String postId);
  Future<void> removeLike(Profile profile, String postId);
  Future<void> savePost(Profile profile, String postId);
  Future<void> removeSavePost(Profile profile, String postId);
  Future<void> addPost(String postId);
  Future<void> logout();
  Future<List<Profile>> getProfilesById(Set<String> profileIds);
  Future<void> updateProfile(Profile oldProfile, Profile newProfile);
  Future<void> deleteSavedPosts(String postId);
}
