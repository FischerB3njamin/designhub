import 'package:designhub/features/profile/data/profile_mock_database.dart';
import 'package:designhub/features/profile/models/profile.dart';

class ProfileSingleton {
  static ProfileSingleton? _instance = ProfileSingleton._internal();
  Profile? profile;

  ProfileSingleton._internal();

  factory ProfileSingleton() {
    _instance ??= ProfileSingleton._internal();
    return _instance!;
  }

  void setProfile(String userId) {
    profile = ProfileMockDatabase().getProfile(userId);
  }

  void logout() {
    _instance = null;
  }
}
