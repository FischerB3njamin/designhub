import 'package:designhub/features/chat/models/chat_item.dart';

class Chat {
  List<ChatItem> chatItems;
  List<String> participants; // profileIds

  Chat({
    required this.chatItems,
    required this.participants,
  });
}
