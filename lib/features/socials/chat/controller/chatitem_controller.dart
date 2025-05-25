import 'package:designhub/features/socials/chat/data/chat_item_repo.dart';
import 'package:designhub/features/socials/chat/models/chat_item.dart';

class ChatItemController {
  final ChatItemRepo _repo;

  ChatItemController(this._repo);

  Future<void> createChatItem(String chatId, ChatItem chatItem) {
    return _repo.createItem(chatId, chatItem);
  }

  Stream<List<ChatItem>> watchChatItems(String chatId) {
    return _repo.watchItems(chatId);
  }

  Future<List<ChatItem>> getChatItems(String chatId) {
    return _repo.getItems(chatId);
  }
}
