import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:designhub/features/socials/chat/data/chat_repo.dart';
import 'package:designhub/features/socials/chat/models/chat.dart';

class ChatFirebaseRepo extends ChatRepo {
  final _collection = FirebaseFirestore.instance.collection('chats');

  @override
  Stream<List<Chat>> watchChats(String userId) {
    return _collection
        .where('participants', arrayContains: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Chat.fromMap(doc.id, doc.data()))
            .toList());
  }

  @override
  Future<void> createChat(Chat chat) async {
    final doc = _collection.doc(chat.id);
    await doc.set(chat.toMap());
  }

  @override
  Future<void> removeChat(String chatId) async {
    await _collection.doc(chatId).delete();
  }

  @override
  Future<void> updateChat(String chatId, Chat chat) async {
    await _collection.doc(chatId).update(chat.toMap());
  }

  @override
  Future<List<Chat>> getChats(String userId) async {
    return await _collection
        .where('participants', arrayContains: userId)
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) => Chat.fromMap(doc.id, doc.data()))
            .toList());
  }
}
