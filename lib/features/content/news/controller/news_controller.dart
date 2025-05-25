import 'package:designhub/features/content/news/data/news_repo.dart';
import 'package:designhub/features/content/news/models/news.dart';

class NewsController {
  NewsRepo repo;
  NewsController(this.repo);

  Stream<List<News>> watch(String profilId) => repo.watch(profilId);

  Future<List<News>> getNews(String profileId) => repo.getNews(profileId);
  Future<void> markNewsAsReaded(news) async => repo.markNewsAsReaded(news);
  Future<void> addNews(news) async => repo.addNews(news);
}
