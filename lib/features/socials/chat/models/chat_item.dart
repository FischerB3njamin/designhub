import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatItem {
  final String id;
  final String chatId;
  final String senderId;
  final String message;
  final DateTime createdAt;

  ChatItem({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.message,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'senderId': senderId,
      'message': base64Encode(utf8.encode(message)),
      'createdAt': createdAt.toUtc(),
    };
  }

  factory ChatItem.fromMap(String id, Map<String, dynamic> map) {
    final createdAtRaw = map['createdAt'];

    final createdAt = createdAtRaw is Timestamp
        ? createdAtRaw.toDate()
        : (createdAtRaw is DateTime ? createdAtRaw : DateTime.now());

    return ChatItem(
        id: id,
        chatId: map['chatId'],
        senderId: map['senderId'],
        message: utf8.decode(base64Decode(map['message'])),
        createdAt: createdAt);
  }
}
