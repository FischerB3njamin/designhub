import 'dart:async';
import 'package:designhub/features/follow/controller/follow_controller.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrentProfileNotifier extends ChangeNotifier {
  String? uid;
  Profile? profile;
  bool isInit = false;
  bool isChanged = false;
  late ProfileController _profileController;
  late FollowController _followerController;
  StreamSubscription<Profile>? _profileSub;
  CurrentProfileNotifier(BuildContext context) {
    _profileController = context.read<ProfileController>();
    _followerController = context.read<FollowController>();
  }

  Profile getProfile() => profile!;
  String getProfileId() => profile!.userId;
  bool getIsChanged() => isChanged;

  bool getLike(String postId) => profile!.liked.contains(postId);
  bool getSavedPost(String postId) => profile!.savedPosts.contains(postId);
  bool getFollowing(String userId) => profile!.following.contains(userId);
  List<String> getFollowers() => profile!.following;
  int getCountFollower() => profile!.following.length;
  void setUid(String newUid) => uid = newUid;
  void setIsChanged(bool value) => isChanged = value;

  Future<bool> init() async {
    _profileSub?.cancel();

    profile = await _profileController.getProfile(uid!);
    isInit = true;
    _profileSub =
        _profileController.watch(profile!.userId).listen((newProfile) {
      isChanged = true;
      profile = newProfile;
      notifyListeners();
    });

    return true;
  }

  void logout() {
    _profileSub?.cancel();
    _profileSub = null;
    profile = null;
    isInit = false;
    notifyListeners();
  }

  Future<void> toggleLike(String postId) async {
    try {
      profile = getLike(postId)
          ? profile!.copyWith(liked: profile!.liked..remove(postId))
          : profile!.copyWith(liked: [...profile!.liked, postId]);

      await _profileController.updateProfile(profile!);
      notifyListeners();
    } catch (e) {
      throw 'Error while updating the like: $e';
    }
  }

  Future<void> toggleSavePost(String postId) async {
    try {
      profile = getSavedPost(postId)
          ? profile!.copyWith(savedPosts: profile!.savedPosts..remove(postId))
          : profile!.copyWith(savedPosts: [...profile!.savedPosts, postId]);

      await _profileController.updateProfile(profile!);
      notifyListeners();
    } catch (e) {
      throw 'Error while updating the saved post: $e';
    }
  }

  Future<void> addMyPost(String postId) async {
    try {
      profile = profile!.copyWith(posts: [...profile!.posts, postId]);

      await _profileController.updateProfile(profile!);

      notifyListeners();
    } catch (e) {
      throw 'Error while saving your created post: $e';
    }
  }

  Future<void> toggleFollowing(String userIdToFollow) async {
    try {
      if (getFollowing(userIdToFollow)) {
        profile = profile!.copyWith(
          following: profile!.following..remove(userIdToFollow),
        );
        await _profileController.updateProfile(profile!);
      } else {
        profile = profile!
            .copyWith(following: [...profile!.following, userIdToFollow]);
        await _profileController.updateProfile(profile!);
      }

      _followerController.toggleFollow(userIdToFollow, profile!.userId);
      notifyListeners();
    } catch (e) {
      throw 'Error while updating the following list: $e';
    }
  }

  void removePost(String postId) {
    _profileController.updateProfile(
        profile!.copyWith(posts: profile!.posts..remove(postId)));
  }

  void removeSavedPost(String postId) {
    _profileController.updateProfile(
        profile!.copyWith(savedPosts: profile!.savedPosts..remove(postId)));
  }

  void removeSosPost(String postId) {
    _profileController.updateProfile(
        profile!.copyWith(sosPosts: profile!.sosPosts..remove(postId)));
  }
}
