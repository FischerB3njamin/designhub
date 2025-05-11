import 'package:designhub/features/news/controller/news_controller.dart';
import 'package:designhub/features/news/models/news.dart';
import 'package:designhub/features/news/models/news_type.dart';
import 'package:designhub/features/posts/controller/post_controller.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/view/post_detail_view.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/features/profile/view/profile_external_page.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsNotifier extends ChangeNotifier {
  bool isInit = false;
  List<News> newsList = [];
  List<Profile> profilesList = [];
  late NewsController newsController;
  late ProfileController profileController;
  NewsNotifier(BuildContext context) {
    newsController = context.read<NewsController>();
    profileController = context.read<ProfileController>();
  }

  bool getHasNews() => newsList.any((e) => e.read == false);

  void init(uid) async {
    newsList = await newsController.getNews(uid);
    profilesList = await profileController
        .getProfilesById(newsList.map((e) => e.creatorId).toSet());

    newsController.watch(uid).listen((data) {
      newsList = data;
      notifyListeners();
    });
    isInit = true;
    notifyListeners();
  }

  Future<void> markNewsAsReaded(news) async {
    newsList[newsList.indexOf(news)].read = true;
    notifyListeners();
    return newsController.markNewsAsReaded(news);
  }

  Future<void> addNews(news) async => newsController.addNews(news);

  String buildItemText(Profile profile, NewsType type) {
    switch (type) {
      case NewsType.comment:
        return "${profile.name} left a comment on your work!";

      case NewsType.feedback:
        return "${profile.name} gave you feedback!";

      case NewsType.follow:
        return "${profile.name} following your work now!";
    }
  }

  void handleNavigation(
    BuildContext context,
    Profile profile,
    String? postId,
    NewsType type,
  ) async {
    Post? post = postId != null
        ? await context.read<PostController>().getPostById(postId)
        : null;

    if (context.mounted) {
      navigation(context, profile, post, type);
    }
  }

  void navigation(
    BuildContext context,
    Profile profile,
    Post? post,
    NewsType type,
  ) {
    if (context.mounted) {
      CustomBottomSheet.show(
        context,
        NewsType.follow == type
            ? ProfileExternalPage(profile: profile)
            : PostDetailView(
                post: post!,
                profile: profile,
              ),
        0.9,
      );
    }
  }
}
