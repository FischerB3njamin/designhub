import 'package:designhub/features/chat/models/chat_item.dart';

abstract class ChatItemRepo {
  Future<List<ChatItem>> getItems(String chatId);
  Stream<List<ChatItem>> watchItems(String chatId);
  Future<void> createItem(String chatId, ChatItem chatItem);
}
