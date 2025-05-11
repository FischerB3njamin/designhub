import 'package:designhub/features/chat/models/chat.dart';

abstract class ChatRepo {
  Stream<List<Chat>> watchChats(String userId);
  Future<List<Chat>> getChats(String userId);
  Future<void> createChat(Chat chat);
  Future<void> removeChat(String chatId);
  Future<void> updateChat(String chatId, Chat chat);
}
