import 'package:designhub/features/chat/models/news.dart';
import 'package:designhub/features/chat/models/news_type.dart';

final List<News> newsData = [
  News(
    read: false,
    profilId: 'uid-0004',
    date: '30.11',
    type: NewsType.follow,
  ),
  News(
    read: false,
    profilId: 'uid-0007',
    date: '30.11',
    type: NewsType.follow,
  ),
  News(
    read: false,
    profilId: 'uid-0006',
    date: '30.11',
    type: NewsType.follow,
  ),
  News(
    read: false,
    profilId: 'uid-0005',
    date: '30.11',
    type: NewsType.follow,
  ),
  News(
    read: false,
    postId: 'po-007',
    profilId: 'uid-0007',
    date: '03.12',
    type: NewsType.feedback,
  ),
  News(
    read: true,
    postId: 'po-005',
    profilId: 'uid-0002',
    date: '06.12',
    type: NewsType.comment,
  ),
  News(
    read: true,
    profilId: 'uid-0003',
    date: '06.12',
    type: NewsType.follow,
  ),
  News(
    read: true,
    postId: 'po-005',
    profilId: 'uid-0002',
    date: '06.12',
    type: NewsType.comment,
  ),
];
