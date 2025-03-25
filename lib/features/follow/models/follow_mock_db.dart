import 'package:designhub/features/follow/data/follower.dart';
import 'package:designhub/features/follow/models/follower_repo.dart';

class FollowMockDb implements FollowerRepo {
  static final FollowMockDb _ = FollowMockDb._internal();
  FollowMockDb._internal();
  factory FollowMockDb() => _;

  List<Follower> data = [];

  @override
  Future<void> addFollow(String profilId, String follower) async {
    // profilId loggedin user -> follower wen ich folgen will
    Future.delayed(Duration(milliseconds: 500), () {
      int index = data.indexWhere((e) => e.profilId == profilId);
      if (index == -1) {
        final newFollower = Follower(profilId: profilId);
        data.add(newFollower);
        index = data.indexWhere((e) => e.profilId == profilId);
      }

      data[index].follow.add(follower);

      int indexMe = data.indexWhere((e) => e.profilId == follower);
      if (indexMe == -1) {
        final newFollower = Follower(profilId: follower);
        data.add(newFollower);
        indexMe = data.indexWhere((e) => e.profilId == follower);
      }
      data[indexMe].followMe.add(profilId);
    });
  }

  @override
  Future<int> countFollow(String profilId) async {
    return Future.delayed(Duration(milliseconds: 500), () {
      int index = data.indexWhere((e) => e.profilId == profilId);
      return index != -1 ? data[index].follow.length : 0;
    });
  }

  @override
  Future<int> countFollowMe(String profilId) {
    return Future.delayed(Duration(milliseconds: 500), () {
      int index = data.indexWhere((e) => e.profilId == profilId);
      return index != -1 ? data[index].followMe.length : 0;
    });
  }

  @override
  Future<List<String>> getFollow(String profilId) {
    return Future.delayed(Duration(milliseconds: 500), () {
      int index = data.indexWhere((e) => e.profilId == profilId);
      return index != -1 ? data[index].follow : <String>[];
    });
  }

  @override
  Future<void> removeFollow(String profilId, String follower) async {
    Future.delayed(Duration(milliseconds: 500), () {
      int index = data.indexWhere((e) => e.profilId == profilId);
      if (index != -1) {
        data[index].follow.remove(follower);
      }

      index = data.indexWhere((e) => e.profilId == follower);
      if (index != -1) {
        data[index].followMe.remove(profilId);
      }
    });
  }

  @override
  Future<List<String>> getFollowMe(String profilId) {
    return Future.delayed(Duration(milliseconds: 500), () {
      int index = data.indexWhere((e) => e.profilId == profilId);
      return index != -1 ? data[index].followMe : <String>[];
    });
  }

  @override
  Future<bool> isFollow(String currentProfilId, String profilId) {
    return Future.delayed(Duration(milliseconds: 500), () {
      int index = data.indexWhere((e) => e.profilId == currentProfilId);
      return index != -1 ? data[index].follow.contains(profilId) : false;
    });
  }
}
