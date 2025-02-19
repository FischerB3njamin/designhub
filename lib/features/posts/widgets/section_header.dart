import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("New Post", style: TextTheme.of(context).headlineLarge),
        IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.close))
      ],
    );
  }
}
