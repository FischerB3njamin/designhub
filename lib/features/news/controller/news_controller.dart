import 'package:designhub/features/news/data/news_mock_db.dart';
import 'package:designhub/features/news/data/news_repo.dart';
import 'package:designhub/features/news/models/news.dart';

class NewsController {
  NewsRepo repo = NewsMockDB();

  Future<List<News>> getNews() => repo.getNews();
  Future<void> markNewsAsReaded(news) async => repo.markNewsAsReaded(news);
  Future<void> addNews(news) async => repo.addNews(news);
}
