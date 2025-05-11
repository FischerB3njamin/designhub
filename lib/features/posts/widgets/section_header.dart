import 'package:designhub/theme/custom_text_styles.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("New Post", style: CustomTextStyles.headlineLarge(context)),
        IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.close))
      ],
    );
  }
}
