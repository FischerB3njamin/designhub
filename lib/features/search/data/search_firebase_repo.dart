import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/search/data/search_repo.dart';

class SearchFirebaseRepo extends SearchRepo {
  final _collectionUsers = FirebaseFirestore.instance.collection('users');
  final _collectionPosts = FirebaseFirestore.instance.collection('posts');

  @override
  Future<List<Post>> searchPosts(
      String query, bool isSos, String userId) async {
    return (await _collectionPosts
            .where('isSos', isEqualTo: isSos)
            .where('searchIndex', isGreaterThanOrEqualTo: query.toLowerCase())
            .where('searchIndex',
                isLessThanOrEqualTo: '${query.toLowerCase()}\uf8ff')
            .where('userId', isNotEqualTo: userId)
            .orderBy('created', descending: true)
            .get())
        .docs
        .map((e) => Post.fromMap(e.data()))
        .toList();
  }

  @override
  Future<List<Profile>> searchProfiles(String query, String userId) async {
    return (await _collectionUsers
            .where('name_low', isGreaterThanOrEqualTo: query.toLowerCase())
            .where('name_low',
                isLessThanOrEqualTo: '${query.toLowerCase()}\uf8ff')
            .where('userId', isNotEqualTo: userId)
            .get())
        .docs
        .map((doc) => Profile.fromMap(doc.data()))
        .toList();
  }
}
