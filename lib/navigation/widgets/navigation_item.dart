import 'package:flutter/cupertino.dart';

class NavigationItem extends StatelessWidget {
  final bool isSelected;
  final Function callback;
  final int index;
  final IconData iconData;
  final String label;
  const NavigationItem({
    super.key,
    required this.isSelected,
    required this.callback,
    required this.index,
    required this.iconData,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(index),
      child: SizedBox(
        width: 50,
        height: 60,
        child: Column(
          spacing: 0,
          children: [
            Icon(
              iconData,
              size: 36,
              color: isSelected ? Color(0xFFF25619) : Color(0xFF000000),
            ),
            if (isSelected)
              Text(
                label,
                style: TextStyle(
                    color: isSelected ? Color(0xFFF25619) : Color(0xFF000000),
                    fontWeight: FontWeight.bold),
              )
          ],
        ),
      ),
    );
  }
}
