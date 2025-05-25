import 'package:designhub/features/socials/profile/models/profile.dart';

abstract class ProfileRepo {
  Stream<Profile> watch(String userId);

  Future<Profile> createProfile(String name, String userId);
  Future<void> updateProfile(Profile newProfile);

  Future<Profile> getProfile(String userId);
  Future<List<Profile>> getProfilesById(Set<String> profileIds);
}
