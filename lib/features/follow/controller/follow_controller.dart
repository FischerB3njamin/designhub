import 'package:designhub/features/follow/models/follow_mock_db.dart';
import 'package:designhub/features/follow/models/follower_repo.dart';

class FollowController {
  FollowerRepo db = FollowMockDb();

  Future<void> addFollow(String profilId, String follower) =>
      db.addFollow(profilId, follower);

  Future<void> removeFollow(String profilId, String follower) =>
      db.removeFollow(profilId, follower);

  Future<List<String>> getFollowMe(String profilId) => db.getFollowMe(profilId);

  Future<List<String>> getFollow(String profilId) => db.getFollow(profilId);
  Future<int> countFollow(String profilId) => db.countFollow(profilId);
  Future<int> countFollowMe(String profilId) => db.countFollowMe(profilId);
  Future<bool> isFollow(String currentProfilId, String profilId) =>
      db.isFollow(currentProfilId, profilId);
}
