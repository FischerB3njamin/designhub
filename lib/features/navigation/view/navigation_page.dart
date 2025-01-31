import 'package:designhub/features/chat/view/chat_page.dart';
import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/features/home/view/home_page.dart';
import 'package:designhub/features/navigation/data/navigation_data.dart';
import 'package:designhub/features/navigation/widgets/navigation_item.dart';
import 'package:designhub/features/profile/view/profile_page.dart';
import 'package:designhub/features/rating/view/rating_page.dart';
import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int activeIndex = 0;
  List<Widget> pages = [HomePage(), ChatPage(), RatingPage(), ProfilePage()];

  void handleIconTap(int index) => setState(() {
        activeIndex = index;
      });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[activeIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Transform.translate(
        offset: Offset(0, 5), // 5 Pixel nach unten verschieben

        child: InkWell(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          onTap: () {},
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
                        returnList.add(SizedBox(
                            width: 80)); // Platz für FloatingActionButton
                      }
                      returnList.add(NavigationItem(
                        icon: entry.value.icon,
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
