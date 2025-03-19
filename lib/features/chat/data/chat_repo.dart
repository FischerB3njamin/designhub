import 'package:designhub/features/chat/models/chat.dart';

abstract class ChatRepo {
  Future<List<Chat>> getChats();
  Future<void> addNewMessage(Chat chat);
  Future<void> markChatAsRead(Chat chat);
}
