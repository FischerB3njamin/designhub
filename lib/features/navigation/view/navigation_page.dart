import 'package:designhub/features/chat/view/chat_news_page.dart';
import 'package:designhub/features/news/controller/news_controller.dart';
import 'package:designhub/features/news/models/news.dart';
import 'package:designhub/features/posts/view/new_post_page.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/features/home/view/home_page.dart';
import 'package:designhub/features/navigation/data/navigation_data.dart';
import 'package:designhub/features/navigation/widgets/navigation_item.dart';
import 'package:designhub/features/profile/view/profile_page.dart';
import 'package:designhub/features/rating/view/rating_overview_page.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key, this.index = 0});
  final int index;

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  late int activeIndex = widget.index;
  final ProfileController profileController = ProfileController();
  final NewsController newsController = NewsController();
  late bool hasNews = false;
  late bool isLoading = true;
  late List<Widget> pages;
  late Profile currentProfile;

  void fetchNews() async {
    List<News> news = await newsController.getNews(currentProfile.userId);

    if (news.where((element) => !element.read).isNotEmpty) {
      setState(() => hasNews = true);
    }
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    currentProfile = profileController.getCurrentProfile();
    super.initState();
    fetchNews();
    pages = [
      HomePage(),
      ChatNewsPage(),
      RatingOverviewPage(),
      ProfilePage(profile: currentProfile)
    ];
  }

  void handleIconTap(int index) => setState(() {
        activeIndex = index;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignhubColors.white,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : pages[activeIndex],
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
                        icon: entry.value.label == 'News' && hasNews
                            ? Assets.icons.newsNew
                            : entry.value.icon,
                        isSelected: activeIndex == entry.key,
                        callback: handleIconTap,
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
