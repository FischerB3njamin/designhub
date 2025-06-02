import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:designhub/features/content/posts/models/post.dart';
import 'package:designhub/features/socials/profile/models/profile.dart';
import 'package:designhub/features/discovery/search/data/search_repo.dart';

class SearchFirebaseRepo extends SearchRepo {
  final FirebaseFirestore firestore;

  SearchFirebaseRepo({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference get _collectionUsers => firestore.collection('profiles');
  CollectionReference get _collectionPosts => firestore.collection('posts');

  @override
  Future<List<Post>> searchPosts(String userId) async {
    return (await _collectionPosts
            .where('userId', isNotEqualTo: userId)
            .orderBy('created', descending: true)
            .get())
        .docs
        .map((e) => Post.fromMap(e.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<Profile>> searchProfiles(String userId) async {
    try {
      return (await _collectionUsers
              .where('userId', isNotEqualTo: userId)
              .get())
          .docs
          .map((doc) => Profile.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
