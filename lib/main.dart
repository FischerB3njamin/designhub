import 'package:designhub/features/auth/controller/auth_controller.dart';
import 'package:designhub/features/auth/data/auth_firebase_repo.dart';
import 'package:designhub/features/auth/provider/auth_notifier.dart';
import 'package:designhub/features/chat/controller/chat_controller.dart';
import 'package:designhub/features/chat/data/chat_firebase_repo.dart';
import 'package:designhub/features/chat/controller/chatitem_controller.dart';
import 'package:designhub/features/chat/data/chat_item_firebase_repo.dart';
import 'package:designhub/features/chat/provider/chat_item_notifier.dart';
import 'package:designhub/features/comment/controller/comment_controller.dart';
import 'package:designhub/features/comment/data/comment_firebase_repo.dart';
import 'package:designhub/features/design_sos/provider/design_sos_notifier.dart';
import 'package:designhub/features/follow/controller/follow_controller.dart';
import 'package:designhub/features/follow/data/follow_firestore_repo.dart';
import 'package:designhub/features/news/controller/news_controller.dart';
import 'package:designhub/features/news/data/news_firebase_repo.dart';
import 'package:designhub/features/posts/controller/post_controller.dart';
import 'package:designhub/features/posts/data/post_firebase_repo.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/features/profile/data/profile_firebase_repo.dart';
import 'package:designhub/features/search/controller/search_controller.dart';
import 'package:designhub/features/search/data/search_firebase_repo.dart';
import 'package:designhub/features/search/provider/search_motifer.dart';
import 'package:designhub/firebase_options.dart';
import 'package:designhub/main_app.dart';
import 'package:designhub/features/profile/provider/current_profile_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:designhub/features/chat/provider/chat_notifier.dart';
import 'package:designhub/features/home/provider/home_notifier.dart';
import 'package:designhub/features/navigation/provider/navigation_notifier.dart';
import 'package:designhub/features/news/provider/news_notifier.dart';
import 'package:designhub/features/profile/provider/profile_notifier.dart';

final bool live = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        Provider<AuthController>(
          create: (_) => AuthController(AuthFirebase(FirebaseAuth.instance)),
        ),
        Provider<ChatController>(
            create: (_) => ChatController(ChatFirebaseRepo())),
        Provider<ChatItemController>(
            create: (_) => ChatItemController(ChatItemFirebaseRepo())),
        Provider<CommentController>(
            create: (_) => CommentController(CommentFirebaseRepo())),
        Provider<FollowController>(
            create: (_) => FollowController(FollowerFirestoreRepo())),
        Provider<NewsController>(
            create: (_) => NewsController(NewsFirebaseRepo())),
        Provider<PostController>(
            create: (_) => PostController(PostFirebaseRepo())),
        Provider<ProfileController>(
            create: (_) => ProfileController(ProfileFirebaseRepo())),
        Provider<SearchControllerCustom>(
            create: (_) => SearchControllerCustom(SearchFirebaseRepo())),
        ChangeNotifierProvider<NewsNotifier>(
          create: (context) => NewsNotifier(context),
        ),
        ChangeNotifierProxyProvider<AuthController, AuthNotifier>(
          create: (context) => AuthNotifier(context),
          update: (context, authController, notifier) {
            notifier ??= AuthNotifier(context);
            return notifier;
          },
        ),
        ChangeNotifierProvider<CurrentProfileNotifier>(
          create: (context) => CurrentProfileNotifier(context),
        ),
        ChangeNotifierProvider<ProfileNotifier>(
          create: (context) => ProfileNotifier(context),
        ),
        ChangeNotifierProvider<ChatItemNotifier>(
          create: (context) => ChatItemNotifier(context),
        ),
        ChangeNotifierProvider<ChatNotifier>(
          create: (context) => ChatNotifier(context),
        ),
        ChangeNotifierProvider<NavigationNotifier>(
          create: (context) => NavigationNotifier(0, context),
        ),
        ChangeNotifierProvider<HomeNotifier>(
          create: (context) => HomeNotifier(context),
        ),
        ChangeNotifierProvider<DesignSosNotifier>(
          create: (context) => DesignSosNotifier(context),
        ),
        ChangeNotifierProvider<SearchNotifier>(
          create: (context) => SearchNotifier(context),
        ),
      ],
      child: const MainApp(),
    ),
  );
}
