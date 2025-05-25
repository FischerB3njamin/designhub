import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chat_bubble_outline,
              size: 64, color: DesignhubColors.grey400),
          const SizedBox(height: 16),
          Text(
            "No chats yet",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: DesignhubColors.grey600),
          ),
          const SizedBox(height: 8),
          Text(
            "Start a new conversation!",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: DesignhubColors.grey500),
          ),
        ],
      ),
    );
  }
}
