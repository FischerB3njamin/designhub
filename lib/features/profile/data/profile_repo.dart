import 'package:designhub/features/profile/models/profile.dart';

abstract class ProfileRepo {
  Profile getProfile(String userId);
  void createProfile(String name, String userId);

  void saveLike(Profile profile, String postId);
  void removeLike(Profile profile, String postId);

  void savePost(Profile profile, String postId);
  void removeSavePost(Profile profile, String postId);
}
