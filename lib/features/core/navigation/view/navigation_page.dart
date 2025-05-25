import 'package:designhub/features/socials/chat/provider/chat_notifier.dart';
import 'package:designhub/features/core/navigation/provider/navigation_notifier.dart';
import 'package:designhub/features/content/news/provider/news_notifier.dart';
import 'package:designhub/features/content/posts/view/new_post_page.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/features/core/navigation/data/navigation_data.dart';
import 'package:designhub/features/core/navigation/widgets/navigation_item.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navigationNotifier = context.watch<NavigationNotifier>();
    final newsNotifier = context.watch<NewsNotifier>();
    final chatNotifier = context.watch<ChatNotifier>();

    return Scaffold(
      backgroundColor: DesignhubColors.white,
      body: navigationNotifier.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : navigationNotifier.activePage,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Transform.translate(
        offset: Offset(0, 5),
        child: InkWell(
          overlayColor: WidgetStateProperty.all(DesignhubColors.transparent),
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => NewPostPage())),
          child: SizedBox(
            height: 100,
            width: 100,
            child: Assets.images.floatingButton.image(),
          ),
        ),
      ),
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Assets.images.bottomBg.image(height: 120, width: double.infinity),
          Positioned(
            bottom: 30,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: NavigationData.items.asMap().entries.expand(
                    (entry) {
                      List<Widget> returnList = [];
                      if (entry.key == 2) {
                        returnList.add(SizedBox(width: 80));
                      }
                      returnList.add(NavigationItem(
                        icon: entry.value.label == 'News' &&
                                (newsNotifier.getHasNews() ||
                                    chatNotifier.hasUnread)
                            ? Assets.icons.newsNew
                            : entry.value.icon,
                        isSelected: navigationNotifier.activeIndex == entry.key,
                        callback: (val) =>
                            navigationNotifier.handleIconTap(val, context),
                        index: entry.key,
                        label: entry.value.label,
                      ));
                      return returnList;
                    },
                  ).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
