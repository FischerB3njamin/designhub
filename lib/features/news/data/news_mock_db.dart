import 'package:designhub/features/news/data/news.mock.dart';
import 'package:designhub/features/news/data/news_repo.dart';
import 'package:designhub/features/news/models/news.dart';

class NewsMockDB extends NewsRepo {
  static final NewsMockDB _ = NewsMockDB._internal();
  NewsMockDB._internal();

  factory NewsMockDB() => _;
  List<News> data = newsData;

  @override
  List<News> getNews() {
    return data;
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
