import 'package:designhub/features/chat/data/chat_mock_db.dart';
import 'package:designhub/features/chat/data/chat_repo.dart';
import 'package:designhub/features/chat/models/chat.dart';
import 'package:designhub/features/chat/models/chat_item.dart';

class ChatController {
  ChatRepo repo = ChatMockDB();

  List<Chat> getChats() => repo.getChats();
  void addNewMessage(Chat chat, ChatItem chatItem) =>
      repo.addNewMessage(chat, chatItem);
}
