import 'package:designhub/features/content/news/models/news.dart';
import 'package:designhub/features/content/news/provider/news_notifier.dart';
import 'package:designhub/features/content/news/widgets/empty_news.dart';
import 'package:designhub/features/content/news/widgets/news_item.dart';
import 'package:designhub/features/socials/profile/models/profile.dart';
import 'package:designhub/features/socials/profile/provider/current_profile_notifier.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:designhub/theme/custom_text_styles.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsView extends StatefulWidget {
  final bool smallView;

  const NewsView({
    super.key,
    required this.smallView,
  });

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  @override
  Widget build(BuildContext context) {
    final newsProvider = context.watch<NewsNotifier>();
    final loginNotifier = context.watch<CurrentProfileNotifier>();

    if (newsProvider.isInit) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: widget.smallView ? 0 : 60,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text("News", style: CustomTextStyles.headlineLarge(context)),
                Spacer(),
                widget.smallView
                    ? _buildAllNewsButton()
                    : IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(Icons.close),
                      ),
              ],
            ),
            SizedBox(height: 8),
            if (newsProvider.newsList.isEmpty) EmptyNews(),
            if (newsProvider.newsList.isNotEmpty)
              ..._buildNewsItems(
                  newsProvider.newsList, newsProvider.profilesList),
          ],
        ),
      );
    } else {
      newsProvider.init(loginNotifier.getProfileId());
    }
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildAllNewsButton() => OutlinedButton(
        onPressed: () async {
          CustomBottomSheet.show(context, NewsView(smallView: false), 1);
        },
        child: Text(
          "Read all",
          style: CustomTextStyles.labelLargeColorBold(
              context, DesignhubColors.primary, FontWeight.w600),
        ),
      );

  List<Widget> _buildNewsItems(
      List<News> newsList, List<Profile> profilesList) {
    return newsList
        .where((e) => profilesList.any((p) => p.userId == e.creatorId))
        .map(
          (e) => NewsItem(
            news: e,
            profile: profilesList.firstWhere((profile) {
              return profile.userId == e.creatorId;
            }),
          ),
        )
        .toList();
  }
}
