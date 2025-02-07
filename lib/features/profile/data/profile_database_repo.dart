import 'package:designhub/features/profile/models/profile.dart';

abstract class ProfileDatabaseRepo {
  Profile getProfile(String userId);
}
