import 'package:designhub/features/socials/chat/data/chat_repo.dart';
import 'package:designhub/features/socials/chat/models/chat.dart';

class ChatController {
  final ChatRepo repo;

  ChatController(this.repo);

  Stream<List<Chat>> watchChats(String userId) => repo.watchChats(userId);
  Future<List<Chat>> getChats(String userId) => repo.getChats(userId);
  Future<void> createChat(Chat chat) => repo.createChat(chat);
  Future<void> removeChat(String chatId) => repo.removeChat(chatId);
  Future<void> updateChat(String chatId, Chat chat) =>
      repo.updateChat(chatId, chat);
}
