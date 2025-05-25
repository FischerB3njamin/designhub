import 'dart:async';

import 'package:designhub/features/socials/profile/data/profile.mock.dart';
import 'package:designhub/features/socials/profile/data/profile_repo.dart';
import 'package:designhub/features/socials/profile/models/profile.dart';

class ProfileMockRepo extends ProfileRepo {
  static final ProfileMockRepo _ = ProfileMockRepo._internal();
  ProfileMockRepo._internal();
  factory ProfileMockRepo() => _;

  final List<Profile> data = profiles;

  final Map<String, StreamController<Profile>> _controllers = {};

  @override
  Stream<Profile> watch(String userId) {
    if (!_controllers.containsKey(userId)) {
      final controller = StreamController<Profile>.broadcast();

      final profile = data.firstWhere(
        (e) => e.userId == userId,
        orElse: () => throw Exception('Profile not found'),
      );
      controller.add(profile);

      _controllers[userId] = controller;
    }
    return _controllers[userId]!.stream;
  }

  void _notifyWatchers(Profile updatedProfile) {
    final controller = _controllers[updatedProfile.userId];
    if (controller != null && !controller.isClosed) {
      controller.add(updatedProfile);
    }
  }

  @override
  Future<Profile> createProfile(String name, String userId) async =>
      Future.delayed(Duration(milliseconds: 100), () {
        final newProfile = Profile(name: name, userId: userId);
        data.add(newProfile);
        _notifyWatchers(newProfile);
        return newProfile;
      });

  @override
  Future<void> updateProfile(Profile newProfile) async {
    return Future.delayed(Duration(milliseconds: 100), () {
      final index = data.indexWhere((e) => e.userId == newProfile.userId);
      if (index != -1) {
        data[index] = newProfile;
        _notifyWatchers(newProfile);
      }
    });
  }

  @override
  Future<Profile> getProfile(String userId) async {
    return Future.delayed(Duration(milliseconds: 100), () {
      return data.firstWhere(
        (item) => item.userId == userId,
        orElse: () => throw Exception('Profile not found'),
      );
    });
  }

  @override
  Future<List<Profile>> getProfilesById(Set<String> profileIds) async {
    return Future.delayed(Duration(milliseconds: 100), () {
      return data.where((e) => profileIds.contains(e.userId)).toList();
    });
  }
}
