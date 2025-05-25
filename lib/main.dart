import 'package:designhub/features/core/auth/controller/auth_controller.dart';
import 'package:designhub/features/core/auth/data/auth_firebase_repo.dart';
import 'package:designhub/features/core/auth/provider/auth_notifier.dart';
import 'package:designhub/features/socials/chat/controller/chat_controller.dart';
import 'package:designhub/features/socials/chat/data/chat_firebase_repo.dart';
import 'package:designhub/features/socials/chat/controller/chatitem_controller.dart';
import 'package:designhub/features/socials/chat/data/chat_item_firebase_repo.dart';
import 'package:designhub/features/socials/chat/provider/chat_item_notifier.dart';
import 'package:designhub/features/content/comment/controller/comment_controller.dart';
import 'package:designhub/features/content/comment/data/comment_firebase_repo.dart';
import 'package:designhub/features/content/design_sos/provider/design_sos_notifier.dart';
import 'package:designhub/features/socials/follow/controller/follow_controller.dart';
import 'package:designhub/features/socials/follow/data/follow_firestore_repo.dart';
import 'package:designhub/features/content/news/controller/news_controller.dart';
import 'package:designhub/features/content/news/data/news_firebase_repo.dart';
import 'package:designhub/features/content/posts/controller/post_controller.dart';
import 'package:designhub/features/content/posts/data/post_firebase_repo.dart';
import 'package:designhub/features/socials/profile/controller/profile_controller.dart';
import 'package:designhub/features/socials/profile/data/profile_firebase_repo.dart';
import 'package:designhub/features/discovery/search/controller/search_controller.dart';
import 'package:designhub/features/discovery/search/data/search_firebase_repo.dart';
import 'package:designhub/features/discovery/search/provider/search_notifer.dart';
import 'package:designhub/firebase_options.dart';
import 'package:designhub/main_app.dart';
import 'package:designhub/features/socials/profile/provider/current_profile_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:designhub/features/socials/chat/provider/chat_notifier.dart';
import 'package:designhub/features/discovery/home/provider/home_notifier.dart';
import 'package:designhub/features/core/navigation/provider/navigation_notifier.dart';
import 'package:designhub/features/content/news/provider/news_notifier.dart';
import 'package:designhub/features/socials/profile/provider/profile_notifier.dart';

final bool live = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Lock orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final FirebaseAuth auth = FirebaseAuth.instance;

  runApp(
    MultiProvider(
      providers: [
        Provider<AuthController>(
          create: (_) => AuthController(AuthFirebase(auth)),
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
        ChangeNotifierProvider<AuthNotifier>(
          create: (context) => AuthNotifier(context),
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
