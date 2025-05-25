import 'package:designhub/theme/custom_text_styles.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class SectionSwitcher extends StatelessWidget {
  final int activeTab;
  final ValueChanged<int> onTabChanged;

  const SectionSwitcher({
    super.key,
    required this.activeTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTab(context, 'All', 1),
        const SizedBox(width: 24),
        _buildTab(context, 'Following', 2),
      ],
    );
  }

  Widget _buildTab(
    BuildContext context,
    String title,
    int index,
  ) {
    final isActive = activeTab == index;

    return GestureDetector(
      onTap: () => onTabChanged(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: CustomTextStyles.bodyLargeColorBold(
                context,
                isActive ? DesignhubColors.black : DesignhubColors.grey,
                isActive ? FontWeight.bold : FontWeight.normal),
          ),
          const SizedBox(height: 4),
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            height: 2,
            width: isActive ? 24 : 0,
            decoration: BoxDecoration(
              color: DesignhubColors.black,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ],
      ),
    );
  }
}
