import 'package:designhub/features/profile/data/profile.mock.dart';
import 'package:designhub/features/profile/data/profile_database_repo.dart';
import 'package:designhub/features/profile/models/profile.dart';

class ProfileMockDatabase extends ProfileDatabaseRepo {
  List<Profile> data = profiles;
  @override
  Profile getProfile(String userId) {
    for (var item in data) {
      if (item.userId == userId) return item;
    }
    throw Exception('Profile not found');
  }
}
