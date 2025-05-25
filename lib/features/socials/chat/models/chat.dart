import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String id;
  final List<String> participants;
  String? lastMessage;
  String? lastSenderId;
  DateTime updatedAt;
  bool unread;
  bool inserted;

  Chat({
    required this.id,
    required this.participants,
    this.lastMessage,
    this.lastSenderId,
    required this.updatedAt,
    required this.unread,
    required this.inserted,
  });

  Map<String, dynamic> toMap() {
    return {
      'participants': participants,
      'lastMessage': base64Encode(utf8.encode(lastMessage ?? '')),
      'lastSenderId': lastSenderId,
      'updatedAt': updatedAt.toUtc(),
      'unread': unread,
    };
  }

  factory Chat.fromMap(String id, Map<String, dynamic> map) {
    final updatedAtRaw = map['updatedAt'];

    final updatedAt = updatedAtRaw is Timestamp
        ? updatedAtRaw.toDate()
        : (updatedAtRaw is DateTime ? updatedAtRaw : DateTime.now());
    return Chat(
        id: id,
        participants: List<String>.from(map['participants']),
        lastMessage: utf8.decode(base64Decode(map['lastMessage'])),
        lastSenderId: map['lastSenderId'],
        updatedAt: updatedAt,
        unread: map['unread'],
        inserted: true);
  }
}
