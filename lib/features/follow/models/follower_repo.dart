abstract class FollowerRepo {
  Future<void> addFollow(String profilId, String follower);
  Future<void> removeFollow(String profilId, String follower);
  Future<List<String>> getFollow(String profilId);
  Future<List<String>> getFollowMe(String profilId);
  Future<int> countFollow(String profilId);
  Future<int> countFollowMe(String profilId);
  Future<bool> isFollow(String currentProfilId, String profilId);
}
