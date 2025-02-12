import 'package:designhub/features/auth/data/login_mock_db.dart';
import 'package:designhub/features/auth/data/login_repo.dart';
import 'package:designhub/features/chat/data/chat_mock_db.dart';
import 'package:designhub/features/chat/data/chat_repo.dart';
import 'package:designhub/features/news/data/news_mock_db.dart';
import 'package:designhub/features/news/data/news_repo.dart';
import 'package:designhub/features/posts/data/post_mock_db.dart';
import 'package:designhub/features/posts/data/post_repo.dart';
import 'package:designhub/features/profile/data/profile_mock_db.dart';
import 'package:designhub/features/profile/data/profile_repo.dart';

class Controller {
  static Controller? _instance = Controller._internal();
  final LoginRepo loginDB;
  final ProfileRepo profileDB;
  final ChatRepo chatDB;
  final NewsRepo newsDB;
  final PostRepo postDB;
  // add rating stuff and comments

  Controller._internal()
      : loginDB = LoginMockDB(),
        profileDB = ProfileMockDB(),
        chatDB = ChatMockDB(),
        newsDB = NewsMockDB(),
        postDB = PostMockDB();

  factory Controller() {
    _instance ??= Controller._internal();
    return _instance!;
  }
}
