import 'package:designhub/gen/assets.gen.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/cupertino.dart';

class NavigationItem extends StatelessWidget {
  final bool isSelected;
  final Function callback;
  final int index;
  final SvgGenImage icon;
  final String label;

  const NavigationItem({
    super.key,
    required this.isSelected,
    required this.callback,
    required this.index,
    required this.icon,
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
            icon.svg(
              width: 25,
              height: 25,
              fit: BoxFit.cover,
              colorFilter: isSelected
                  ? ColorFilter.mode(DesignhubColors.primary, BlendMode.srcIn)
                  : null,
            ),
            if (isSelected)
              Text(
                label,
                style: TextStyle(
                  color: isSelected
                      ? DesignhubColors.primary
                      : DesignhubColors.black,
                  fontWeight: FontWeight.bold,
                ),
              )
          ],
        ),
      ),
    );
  }
}
