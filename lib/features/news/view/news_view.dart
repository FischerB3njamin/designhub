import 'package:designhub/features/news/controller/news_controller.dart';
import 'package:designhub/features/news/models/news.dart';
import 'package:designhub/features/news/widgets/news_item.dart';
import 'package:designhub/features/profile/data/profile.mock.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class NewsView extends StatefulWidget {
  final bool smallView;
  final List<News> news;
  final List<Profile> profiles;

  const NewsView({
    super.key,
    required this.smallView,
    required this.news,
    required this.profiles,
  });

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  final controller = NewsController();
  void callBack(News news) {
    controller.markNewsAsReaded(news);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<News> news =
        widget.smallView ? widget.news.sublist(0, 5) : widget.news;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: widget.smallView ? 0 : 60,
      ),
      child: ListView(children: [
        Row(
          children: [
            Text(
              "News",
              style: TextTheme.of(context).headlineLarge,
            ),
            Spacer(),
            widget.smallView
                ? OutlinedButton(
                    onPressed: () async {
                      CustomBottomSheet.show(
                          context,
                          NewsView(
                            smallView: false,
                            news: widget.news,
                            profiles: widget.profiles,
                          ),
                          1);
                      setState(() {});
                    },
                    child: Text(
                      "Read all",
                      style: TextTheme.of(context).labelLarge!.copyWith(
                          color: DesignhubColors.primary,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                : IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close),
                  ),
          ],
        ),
        SizedBox(height: 8),
        ...news.map(
          (e) => NewsItem(
            news: e,
            callback: callBack,
            profile:
                profiles.firstWhere((profile) => profile.userId == e.profilId),
          ),
        ),
      ]),
    );
  }
}
