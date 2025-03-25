import 'package:designhub/features/chat/data/chat_mock_db.dart';
import 'package:designhub/features/chat/data/chat_repo.dart';
import 'package:designhub/features/chat/models/chat.dart';

class ChatController {
  ChatRepo repo = ChatMockDB();

  Future<List<Chat>> getChats() => repo.getChats();
  Future<Chat?> getChatByParticipants(String sender, String reciever) =>
      repo.getChatByParticipants(sender, reciever);
  Future<void> addNewMessage(Chat chat) async => repo.addNewMessage(chat);
  Future<void> markAsRead(Chat chat) => repo.markChatAsRead(chat);
}
