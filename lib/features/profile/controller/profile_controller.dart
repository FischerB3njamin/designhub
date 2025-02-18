import 'package:designhub/features/profile/data/profile_mock_db.dart';
import 'package:designhub/features/profile/data/profile_repo.dart';
import 'package:designhub/features/profile/models/profile.dart';

class ProfileController {
  ProfileRepo repo = ProfileMockDB();
  void logout() => repo.logout();
  Profile getProfile(String userId) => repo.getProfile(userId);

  void setCurrentProfile(String id) => repo.setCurrentProfile(id);

  Profile getCurrentProfile() => repo.currentProfile!;

  void createProfile(String name, String userId) =>
      repo.createProfile(name, userId);

  void saveLike(Profile profile, String postId) =>
      repo.saveLike(profile, postId);

  void removeLike(Profile profile, String postId) =>
      repo.removeLike(profile, postId);

  void removeSavePost(Profile profile, String postId) =>
      repo.removeSavePost(profile, postId);

  void savePost(Profile profile, String postId) =>
      repo.savePost(profile, postId);
  void addPost(String postId) => repo.addPost(postId);
}
