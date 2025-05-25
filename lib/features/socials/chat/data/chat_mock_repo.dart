import 'dart:async';
import 'package:designhub/features/socials/chat/data/chat_repo.dart';
import 'package:designhub/features/socials/chat/models/chat.dart';

class ChatMockRepo extends ChatRepo {
  static final ChatMockRepo _instance = ChatMockRepo._internal();
  ChatMockRepo._internal();
  factory ChatMockRepo() => _instance;

  final List<Chat> _data = [];
  final StreamController<List<Chat>> _controller = StreamController.broadcast();

  List<Chat> get chats => _data;

  void _notify() => _controller.add(List.from(_data));

  @override
  Stream<List<Chat>> watchChats(String userId) {
    return _controller.stream.map(
      (list) =>
          list.where((chat) => chat.participants.contains(userId)).toList(),
    );
  }

  @override
  Future<void> createChat(Chat chat) async {
    await Future.delayed(Duration(milliseconds: 300), () {
      _data.add(chat);
      _notify();
    });
  }

  @override
  Future<void> removeChat(String chatId) async {
    _data.removeWhere((chat) => chat.id == chatId);
    _notify();
  }

  @override
  Future<void> updateChat(String chatId, Chat chat) async {
    final index = _data.indexWhere((c) => c.id == chatId);
    if (index != -1) {
      _data[index] = chat;
      _notify();
    }
  }

  @override
  Future<List<Chat>> getChats(String userId) async {
    return Future.delayed(Duration(milliseconds: 100), () {
      return _data.where((chat) => chat.participants.contains(userId)).toList();
    });
  }

  Chat getChatById(String chatId) =>
      _data.firstWhere((chat) => chat.id == chatId);
}
