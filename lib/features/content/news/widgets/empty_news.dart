import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class EmptyNews extends StatelessWidget {
  const EmptyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.new_releases_outlined,
                size: 64, color: DesignhubColors.black.withAlpha(50)),
            const SizedBox(height: 16),
            Text(
              "No News available",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: DesignhubColors.black.withAlpha(130)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
