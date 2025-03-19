import 'package:designhub/features/news/models/news_type.dart';

class News {
  String? postId;
  String profilId;
  String creatorId;
  String date;
  bool read;

  NewsType type;
  News({
    this.postId,
    required this.profilId,
    required this.creatorId,
    required this.date,
    required this.type,
    required this.read,
  });
}
