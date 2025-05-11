import 'dart:async';
import 'package:designhub/features/chat/controller/chat_controller.dart';
import 'package:designhub/features/chat/models/chat.dart';
import 'package:designhub/features/chat/controller/chatitem_controller.dart';
import 'package:designhub/shared/provider/base_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:designhub/features/chat/models/chat_item.dart';

class ChatItemNotifier extends BaseUiProvider {
  String? _chatId;
  late Chat _chat;

  late final ChatItemController _controller;
  late final ChatController _chatController;

  List<ChatItem> data = [];
  StreamSubscription<List<ChatItem>>? _chatItemSubscription;

  ChatItemNotifier(BuildContext context) {
    _controller = context.read<ChatItemController>();
    _chatController = context.read<ChatController>();
  }

  Future<void> init(Chat chat) async {
    data = [];
    _chat = chat;
    setLoading(true);
    _chatId = chat.id;

    try {
      final items = await _controller.getChatItems(_chatId!);
      data = items;
      _chatItemSubscription?.cancel();
      _chatItemSubscription = _controller.watchChatItems(_chatId!).listen(
        (items) {
          data = items;
          notifyListeners();
        },
        onError: (error) {
          setError(error.toString());
        },
      );
      setLoading(false);
    } catch (e) {
      setError(e.toString());
    }
    setLoading(false);
  }

  Future<void> sendChatItem(String text, String userId) async {
    try {
      _chat.lastMessage = text;
      _chat.lastSenderId = userId;
      _chat.unread = true;
      if (!_chat.inserted) {
        _chat.inserted = true;
        await _chatController.createChat(_chat);
      } else {
        _chatController.updateChat(_chat.id, _chat);
      }

      await _controller.createChatItem(
          _chatId!,
          ChatItem(
              senderId: userId,
              message: text,
              createdAt: DateTime.now(),
              chatId: _chat.id,
              id: ''));
    } catch (e) {
      setError(e.toString());
    }
  }

  @override
  void dispose() {
    _chatItemSubscription?.cancel();
    super.dispose();
  }
}
