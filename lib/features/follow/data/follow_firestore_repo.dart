import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:designhub/features/follow/data/follower_repo.dart';
import 'package:designhub/features/follow/models/follower.dart';

class FollowerFirestoreRepo extends FollowerRepo {
  final _collection = FirebaseFirestore.instance.collection('follower');

  FollowerFirestoreRepo();

  @override
  Future<Follower?> getFollower(String profilId) async {
    final snapshot = await _collection.doc(profilId).get();
    return snapshot.exists ? Follower.fromMap(snapshot.data()!) : null;
  }

  @override
  Future<void> toggleFollow(String targetUserId, String followerId) async {
    final docRef = _collection.doc(targetUserId);
    final snapshot = await docRef.get();

    if (!snapshot.exists) {
      final newFollower =
          Follower(profilId: targetUserId, followMe: [followerId]);
      await docRef.set(newFollower.toMap());
      return;
    }

    final current = Follower.fromMap(snapshot.data()!);

    final updatedList = current.followMe.contains(followerId)
        ? current.followMe.where((id) => id != followerId).toList()
        : [...current.followMe, followerId];

    await docRef.update({
      'followMe': updatedList,
    });
  }
}
