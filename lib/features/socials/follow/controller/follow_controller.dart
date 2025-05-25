import 'package:designhub/features/socials/follow/models/follower.dart';
import 'package:designhub/features/socials/follow/data/follower_repo.dart';

class FollowController {
  FollowerRepo repo;
  FollowController(this.repo);
  Future<Follower?> getFollower(String profilId) => repo.getFollower(profilId);
  Future<void> toggleFollow(String targetUserId, String followerId) =>
      repo.toggleFollow(targetUserId, followerId);
}
