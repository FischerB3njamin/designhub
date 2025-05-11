import 'package:designhub/features/follow/models/follower.dart';
import 'package:designhub/features/follow/data/follower_repo.dart';

class FollowMockRepo implements FollowerRepo {
  static final FollowMockRepo _ = FollowMockRepo._internal();
  FollowMockRepo._internal();
  factory FollowMockRepo() => _;

  List<Follower> data = [];

  @override
  Future<void> toggleFollow(String targetUserId, String followerId) async {
    final index = data.indexWhere((e) => e.profilId == targetUserId);

    if (index >= 0) {
      final current = data[index];
      final isFollowing = current.followMe.contains(followerId);

      data[index] = current.copyWith(
        followMe: isFollowing
            ? current.followMe.where((id) => id != followerId).toList()
            : [...current.followMe, followerId],
      );
      return;
    }

    final followData = Follower(profilId: targetUserId, followMe: [followerId]);
    data.add(followData);
  }

  @override
  Future<Follower?> getFollower(String profilId) async {
    return data[data.indexWhere((e) => e.profilId == profilId)];
  }
}
