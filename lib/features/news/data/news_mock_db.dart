import 'package:designhub/features/news/data/news.mock.dart';
import 'package:designhub/features/news/data/news_repo.dart';
import 'package:designhub/features/news/models/news.dart';

class NewsMockDB extends NewsRepo {
  static final NewsMockDB _ = NewsMockDB._internal();
  NewsMockDB._internal();

  factory NewsMockDB() => _;
  List<News> data = newsData;

  @override
  Future<List<News>> getNews(String profileId) async {
    return Future.delayed(Duration(seconds: 1), () {
      return data.where((element) => element.profilId == profileId).toList();
    });
  }

  @override
  Future<void> markNewsAsReaded(news) async {
    data[data.indexOf(news)].read = true;
  }

  @override
  Future<void> addNews(news) async {
    data.add(news);
    print(news);
  }
}
