import 'package:designhub/features/chat/data/chat.mock.dart';
import 'package:designhub/features/chat/data/chat_repo.dart';
import 'package:designhub/features/chat/models/chat.dart';

class ChatMockDB extends ChatRepo {
  static final ChatMockDB _ = ChatMockDB._internal();
  ChatMockDB._internal();

  factory ChatMockDB() => _;
  List<Chat> data = mockChats;

  @override
  Future<void> addNewMessage(Chat chat) async {
    return Future.delayed(Duration(seconds: 1), () {
      chat.newMessage = true;
      data.remove(chat);
      data.insert(0, chat);
    });
  }

  @override
  Future<List<Chat>> getChats() {
    return Future.delayed(Duration(seconds: 1), () {
      return data;
    });
  }

  @override
  Future<void> markChatAsRead(Chat chat) {
    return Future.delayed(Duration(seconds: 1),
        () => data[data.indexOf(chat)].newMessage = false);
  }
}
