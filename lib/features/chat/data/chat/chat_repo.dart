import 'package:designhub/features/chat/models/chat.dart';
import 'package:designhub/features/chat/models/chat_item.dart';

abstract class ChatRepo {
  List<Chat> getChats();

  void addNewMessage(Chat chat, ChatItem chatItem);
}
