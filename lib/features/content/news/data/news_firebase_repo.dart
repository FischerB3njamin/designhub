import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:designhub/features/content/news/data/news_repo.dart';
import 'package:designhub/features/content/news/models/news.dart';

class NewsFirebaseRepo extends NewsRepo {
  final _collection = FirebaseFirestore.instance.collection('news');

  @override
  Future<List<News>> getNews(String profileId) async {
    final snapshot = await _collection
        .where('profilId', isEqualTo: profileId)
        .orderBy('date', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => News.fromMap(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<void> addNews(News news) async {
    await _collection.add(news.toMap());
  }

  @override
  Future<void> markNewsAsReaded(News news) async {
    await _collection.doc(news.id).update({'read': true});
  }

  @override
  Stream<List<News>> watch(String profilId) {
    return _collection
        .where('profilId', isEqualTo: profilId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return News.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }
}
