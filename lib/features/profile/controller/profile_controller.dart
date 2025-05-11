import 'package:designhub/features/profile/data/profile_repo.dart';
import 'package:designhub/features/profile/models/profile.dart';

class ProfileController {
  ProfileRepo repo;
  ProfileController(this.repo);

  Stream<Profile> watch(String userId) => repo.watch(userId);

  Future<void> updateProfile(Profile newProfile) =>
      repo.updateProfile(newProfile);

  Future<Profile> getProfile(String userId) => repo.getProfile(userId);

  Future<List<Profile>> getProfilesById(Set<String> profileIds) =>
      repo.getProfilesById(profileIds);
}
