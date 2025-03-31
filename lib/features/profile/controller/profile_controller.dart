import 'package:designhub/features/profile/data/profile_mock_db.dart';
import 'package:designhub/features/profile/data/profile_repo.dart';
import 'package:designhub/features/profile/models/profile.dart';

class ProfileController {
  ProfileRepo repo = ProfileMockDB();
  void logout() => repo.logout();
  Future<Profile> getProfile(String userId) => repo.getProfile(userId);

  Future<bool> setCurrentProfile(String userId) =>
      repo.setCurrentProfile(userId);

  Profile getCurrentProfile() => repo.currentProfile!;

  Future<Profile> createProfile(String name, String userId) =>
      repo.createProfile(name, userId);

  Future<void> saveLike(Profile profile, String postId) =>
      repo.saveLike(profile, postId);

  Future<void> removeLike(Profile profile, String postId) =>
      repo.removeLike(profile, postId);

  Future<void> removeSavePost(Profile profile, String postId) =>
      repo.removeSavePost(profile, postId);

  Future<void> savePost(Profile profile, String postId) =>
      repo.savePost(profile, postId);
  Future<void> addPost(String postId) => repo.addPost(postId);

  Future<List<Profile>> getProfilesById(Set<String> profileIds) =>
      repo.getProfilesById(profileIds);

  Future<void> updateProfile(Profile oldProfile, Profile newProfile) =>
      repo.updateProfile(oldProfile, newProfile);

  Future<void> deleteSavedPosts(String postId) async {
    await repo.deleteSavedPosts(postId);
    await setCurrentProfile(
        (await getProfile(getCurrentProfile().userId)).userId);
  }
}
