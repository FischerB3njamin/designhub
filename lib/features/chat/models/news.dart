import 'package:designhub/features/chat/models/news_type.dart';

class News {
  String? postId;
  String profilId;
  String date;
  bool read;

  NewsType type;
  News({
    this.postId,
    required this.profilId,
    required this.date,
    required this.type,
    required this.read,
  });
}
