import 'package:designhub/features/news/models/news.dart';

abstract class NewsRepo {
  List<News> getNews();
  void markNewsAsReaded(news);
  void addNews(news);
}
