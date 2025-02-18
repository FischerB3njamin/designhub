import 'package:designhub/features/news/data/news_mock_db.dart';
import 'package:designhub/features/news/data/news_repo.dart';
import 'package:designhub/features/news/models/news.dart';

class NewsController {
  NewsRepo repo = NewsMockDB();

  List<News> getNews() => repo.getNews();
  void markNewsAsReaded(news) => repo.markNewsAsReaded(news);
  void addNews(news) => repo.addNews(news);
}
