import 'package:flutter/material.dart';

class SectionSwitcher extends StatelessWidget {
  final Function callback;
  final int active;
  final bool hasFollower;
  const SectionSwitcher(
      {super.key,
      required this.callback,
      required this.active,
      required this.hasFollower});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => callback(1),
          child: Text(
            'For you',
            style: active == 1
                ? TextTheme.of(context)
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold)
                : TextTheme.of(context).bodyLarge,
          ),
        ),
        SizedBox(width: 16),
        GestureDetector(
          onTap: () => callback(2),
          child: Text(
            'Following',
            style: active == 2
                ? TextTheme.of(context)
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold)
                : TextTheme.of(context).bodyLarge,
          ),
        ),
      ],
    );
  }
}
