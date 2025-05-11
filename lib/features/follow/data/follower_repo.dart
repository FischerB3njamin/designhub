import 'package:designhub/features/follow/models/follower.dart';

abstract class FollowerRepo {
  Future<Follower?> getFollower(String profilId);
  Future<void> toggleFollow(String targetUserId, String followerId);
}
