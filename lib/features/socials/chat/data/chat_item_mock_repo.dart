import 'dart:async';

import 'package:designhub/features/socials/chat/data/chat_item_repo.dart';
import 'package:designhub/features/socials/chat/models/chat_item.dart';

class ChatItemMockRepo extends ChatItemRepo {
  final List<ChatItem> _chatItems = [];

  final StreamController<List<ChatItem>> _chatItemStreamController =
      StreamController<List<ChatItem>>.broadcast();

  ChatItemMockRepo() {
    _chatItemStreamController.add(_chatItems);
  }

  void _updateStream() {
    _chatItemStreamController.add(List.unmodifiable(_chatItems));
  }

  @override
  Future<void> createItem(String chatId, ChatItem chatItem) async {
    _chatItems.add(chatItem);
    _updateStream();
  }

  @override
  Stream<List<ChatItem>> watchItems(String chatId) {
    return _chatItemStreamController.stream.map(
      (items) => items.where((item) => item.chatId == chatId).toList(),
    );
  }

  @override
  Future<List<ChatItem>> getItems(String chatId) async {
    return _chatItems.where((item) => item.chatId == chatId).toList();
  }
}
