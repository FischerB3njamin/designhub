import 'package:designhub/features/chat/data/chat/chat.mock.dart';
import 'package:designhub/features/chat/data/chat/chat_repo.dart';
import 'package:designhub/features/chat/models/chat.dart';
import 'package:designhub/features/chat/models/chat_item.dart';

class ChatMockDatabase extends ChatRepo {
  List<Chat> data = mockChats;

  @override
  void addNewMessage(Chat chat, ChatItem chatItem) {
    data[data.indexOf(chat)].chatItems.add(chatItem);
  }

  @override
  List<Chat> getChats() {
    return data;
  }
}
