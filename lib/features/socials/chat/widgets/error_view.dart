import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorView({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: DesignhubColors.red),
            const SizedBox(height: 16),
            Text(
              "Oops, something went wrong.\n Please try again later ",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: DesignhubColors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
