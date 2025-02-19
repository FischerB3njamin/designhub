import 'package:designhub/features/news/models/news.dart';

abstract class NewsRepo {
  Future<List<News>> getNews();
  Future<void> markNewsAsReaded(news);
  Future<void> addNews(news);
}
