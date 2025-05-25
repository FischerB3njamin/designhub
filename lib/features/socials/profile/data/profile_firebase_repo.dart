import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:designhub/features/socials/profile/data/profile_repo.dart';
import 'package:designhub/features/socials/profile/models/profile.dart';

class ProfileFirebaseRepo implements ProfileRepo {
  final _collection = FirebaseFirestore.instance.collection('profiles');

  @override
  Stream<Profile> watch(String userId) {
    return _collection.doc(userId).snapshots().map(
          (doc) => Profile.fromMap(doc.data() as Map<String, dynamic>),
        );
  }

  @override
  Future<Profile> createProfile(String name, String userId) async {
    try {
      final newProfile = Profile(
        userId: userId,
        name: name,
        aboutMe: '',
        avatarImagePath: '',
        backgroundImagePath: '',
        interests: '',
      );

      await _collection.doc(userId).set(newProfile.toMap());
      return newProfile;
    } catch (e) {
      throw 'Error on Profile creation  $e';
    }
  }

  @override
  Future<void> updateProfile(Profile newProfile) async {
    try {
      await _collection.doc(newProfile.userId).update(newProfile.toMap());
    } catch (e) {
      throw 'Error on update Profile: $e';
    }
  }

  @override
  Future<Profile> getProfile(String userId) async {
    try {
      final doc = await _collection.doc(userId).get();
      return doc.exists
          ? Profile.fromMap(doc.data() as Map<String, dynamic>)
          : await createProfile('', userId);
    } catch (e) {
      throw 'Error with the Profile: $e';
    }
  }

  @override
  Future<List<Profile>> getProfilesById(Set<String> profileIds) async {
    try {
      return (await Future.wait(
              profileIds.map((id) => _collection.doc(id).get())))
          .where((doc) => doc.exists)
          .map((doc) => Profile.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw 'Error with the Profile: $e';
    }
  }
}
