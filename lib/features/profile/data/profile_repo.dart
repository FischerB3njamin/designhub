import 'package:designhub/features/profile/models/profile.dart';

abstract class ProfileRepo {
  Profile getProfile(String userId);
}
