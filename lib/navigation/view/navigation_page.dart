import 'package:designhub/chat/view/chat_page.dart';
import 'package:designhub/home/view/home_page.dart';
import 'package:designhub/navigation/data/navigation_data.dart';
import 'package:designhub/navigation/widgets/navigation_item.dart';
import 'package:designhub/profile/view/profile_page.dart';
import 'package:designhub/rating/view/rating_page.dart';
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
      floatingActionButton: Transform.rotate(
        angle: 0.75,
        origin: Offset(0, 0),
        child: SizedBox(
          width: 80,
          height: 80,
          child: FittedBox(
            child: FloatingActionButton(
              // elevation: 0,
              backgroundColor: Color(0xFFF25619),
              onPressed: () {},
              child: Transform.rotate(
                angle: -0.75,
                child: Icon(
                  Icons.add,
                  size: 36,
                  color: Color(0xFFFFFEFE),
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: BottomAppBar(
          height: 100,
          padding: EdgeInsets.all(16),
          color: Color(0xFFF8F7F4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: NavigationData.items.asMap().entries.expand(
              (entry) {
                List<Widget> returnList = [];

                // Spacer an 2. Stelle
                if (entry.key == 2) returnList.add(Spacer());

                returnList.add(NavigationItem(
                  iconData: entry.value.iconData,
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
    );
  }
}
