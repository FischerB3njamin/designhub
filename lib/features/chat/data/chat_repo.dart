import 'package:designhub/features/chat/models/chat.dart';
import 'package:designhub/features/chat/models/chat_item.dart';

abstract class ChatRepo {
  Future<List<Chat>> getChats();
  Future<void> addNewMessage(Chat chat, ChatItem chatItem);
}
