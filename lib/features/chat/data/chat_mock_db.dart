import 'package:designhub/features/chat/data/chat.mock.dart';
import 'package:designhub/features/chat/data/chat_repo.dart';
import 'package:designhub/features/chat/models/chat.dart';
import 'package:designhub/features/chat/models/chat_item.dart';

class ChatMockDB extends ChatRepo {
  static final ChatMockDB _ = ChatMockDB._internal();
  ChatMockDB._internal();

  factory ChatMockDB() => _;
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
