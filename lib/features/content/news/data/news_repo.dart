import 'package:designhub/features/content/news/models/news.dart';

abstract class NewsRepo {
  Future<List<News>> getNews(String profileId);
  Future<void> markNewsAsReaded(News news);
  Future<void> addNews(News news);
  Stream<List<News>> watch(String profilId);
}
