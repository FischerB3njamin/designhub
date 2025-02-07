import 'package:designhub/features/chat/data/news/news.mock.dart';
import 'package:designhub/features/chat/data/news/news_repo.dart';
import 'package:designhub/features/chat/models/news.dart';

class NewsMockDatabase extends NewsRepo {
  static NewsMockDatabase? _instance = NewsMockDatabase._internal();
  List<News> data = newsData;
  @override
  List<News> getNews() {
    return data;
  }

  NewsMockDatabase._internal();
  factory NewsMockDatabase() {
    _instance ??= NewsMockDatabase._internal();
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
