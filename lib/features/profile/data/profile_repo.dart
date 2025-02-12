import 'package:designhub/features/profile/models/profile.dart';

abstract class ProfileRepo {
  Profile getProfile(String userId);
  void createProfile(String name, String userId);
}
