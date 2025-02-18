import 'package:designhub/features/chat/models/chat_item.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/shared/widgets/avatar_circle.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class ChatDetailItemReciever extends StatelessWidget {
  final ChatItem item;
  final ProfileController profileController = ProfileController();
  ChatDetailItemReciever({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              constraints: BoxConstraints(minHeight: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      border: Border.all(color: DesignhubColors.grey400),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      item.text,
                    ),
                  ),
                  Text(
                    item.date,
                    style: TextTheme.of(context).labelSmall!.copyWith(
                          color: DesignhubColors.black.withAlpha(200),
                        ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 4),
          AvatarCircle(
            width: 50,
            height: 50,
            profilId: profileController.getCurrentProfile().userId,
          ),
        ],
      ),
    );
  }
}
