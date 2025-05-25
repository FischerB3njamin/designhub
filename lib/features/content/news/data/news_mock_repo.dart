import 'dart:async';

import 'package:designhub/features/content/news/data/news_repo.dart';
import 'package:designhub/features/content/news/models/news.dart';

class NewsMockRepo extends NewsRepo {
  static final NewsMockRepo _ = NewsMockRepo._internal();
  NewsMockRepo._internal();

  factory NewsMockRepo() => _;

  final List<News> data = [];
  final StreamController<List<News>> _newsController =
      StreamController.broadcast();

  void _emit(String profilId) {
    final filtered = data.where((n) => n.profilId == profilId).toList();
    _newsController.add(filtered);
  }

  @override
  Future<List<News>> getNews(String profileId) async {
    return Future.delayed(Duration(milliseconds: 100), () {
      return data.where((element) => element.profilId == profileId).toList();
    });
  }

  @override
  Future<void> markNewsAsReaded(news) async {
    final index = data.indexOf(news);
    if (index != -1) {
      data[index].read = true;
      _emit(news.profilId);
    }
  }

  @override
  Future<void> addNews(news) async {
    data.insert(0, news);
    _emit(news.profilId);
  }

  @override
  Stream<List<News>> watch(String profilId) {
    Future.microtask(() => _emit(profilId));
    return _newsController.stream;
  }

  void dispose() {
    _newsController.close();
  }
}
