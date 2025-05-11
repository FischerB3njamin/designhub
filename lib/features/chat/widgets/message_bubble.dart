import 'package:designhub/features/chat/models/chat_item.dart';
import 'package:designhub/theme/custom_text_styles.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final ChatItem item;
  final bool isSender;

  const MessageBubble({
    super.key,
    required this.item,
    required this.isSender,
  });

  @override
  Widget build(BuildContext context) {
    final bubbleColor =
        isSender ? DesignhubColors.primary100 : DesignhubColors.white;
    final textColor = DesignhubColors.black;
    final time = _formatTime(item.createdAt);

    return Column(
      crossAxisAlignment:
          isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 280),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: bubbleColor,
            border: Border.all(color: DesignhubColors.grey300),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
              bottomLeft: Radius.circular(isSender ? 16 : 0),
              bottomRight: Radius.circular(isSender ? 0 : 16),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  item.message,
                  style: CustomTextStyles.bodyMediumColor(context, textColor),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 6),
        Text(
          time,
          style: CustomTextStyles.labelSmallColor(
              context, DesignhubColors.grey600),
        ),
      ],
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final isToday = now.year == dateTime.year &&
        now.month == dateTime.month &&
        now.day == dateTime.day;

    if (isToday) {
      final time = TimeOfDay.fromDateTime(dateTime);
      final hour = time.hour.toString().padLeft(2, '0');
      final minute = time.minute.toString().padLeft(2, '0');
      return '$hour:$minute';
    } else {
      final day = dateTime.day.toString().padLeft(2, '0');
      final month = dateTime.month.toString().padLeft(2, '0');
      return '$day.$month';
    }
  }
}
