import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:designhub/features/socials/chat/models/chat_item.dart';
import 'package:designhub/features/socials/chat/data/chat_item_repo.dart';

class ChatItemFirebaseRepo extends ChatItemRepo {
  final _collection = FirebaseFirestore.instance.collection('chats');

  @override
  Future<void> createItem(String chatId, ChatItem chatItem) async {
    try {
      await _collection
          .doc(chatId)
          .collection('chatItems')
          .add(chatItem.toMap());
    } catch (e) {
      throw Exception('Failed to create chat item');
    }
  }

  @override
  Stream<List<ChatItem>> watchItems(String chatId) {
    return _collection
        .doc(chatId)
        .collection('chatItems')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ChatItem.fromMap(doc.id, doc.data());
      }).toList();
    });
  }

  @override
  Future<List<ChatItem>> getItems(String chatId) async {
    final snapshot = await _collection
        .doc(chatId)
        .collection('chatItems')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      return ChatItem.fromMap(doc.id, doc.data());
    }).toList();
  }
}
