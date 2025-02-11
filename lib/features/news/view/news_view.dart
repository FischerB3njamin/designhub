import 'package:designhub/features/news/data/news_mock_database.dart';
import 'package:designhub/features/chat/models/news.dart';
import 'package:designhub/features/news/widgets/news_item.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class NewsView extends StatefulWidget {
  final bool smallView;
  const NewsView({super.key, required this.smallView});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  NewsMockDatabase db = NewsMockDatabase();
  late List<News> newsData = db.getNews();

  @override
  Widget build(BuildContext context) {
    List<News> news = widget.smallView ? newsData.sublist(0, 5) : newsData;

    void callBack(News news) {
      db.markNewsAsReaded(news);
      setState(() {});
    }

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
                          context, NewsView(smallView: false), 1);
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
        ...news.map((e) => NewsItem(news: e, callback: callBack)),
      ]),
    );
  }
}
