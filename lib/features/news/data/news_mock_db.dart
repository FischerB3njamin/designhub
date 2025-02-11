import 'package:designhub/features/news/data/news.mock.dart';
import 'package:designhub/features/news/data/news_repo.dart';
import 'package:designhub/features/news/models/news.dart';

class NewsMockDB extends NewsRepo {
  static NewsMockDB? _instance = NewsMockDB._internal();
  List<News> data = newsData;
  @override
  List<News> getNews() {
    return data;
  }

  NewsMockDB._internal();
  factory NewsMockDB() {
    _instance ??= NewsMockDB._internal();
    return _instance!;
  }

  @override
  void markNewsAsReaded(news) {
    data[data.indexOf(news)].read = true;
  }

  @override
  void addNews(news) {
    data.add(news);
  }
}
