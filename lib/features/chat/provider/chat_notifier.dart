import 'dart:async';
import 'package:designhub/features/chat/controller/chat_controller.dart';
import 'package:designhub/features/chat/models/chat.dart';
import 'package:designhub/features/chat/provider/chat_item_notifier.dart';
import 'package:designhub/features/chat/view/chat_detail_screen.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/shared/provider/base_provider.dart';
import 'package:designhub/features/profile/provider/current_profile_notifier.dart';
import 'package:designhub/shared/view/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatNotifier extends BaseUiProvider {
  late ChatController _chatController;
  late ProfileController _profileController;
  late CurrentProfileNotifier _currentProfileNotifier;
  late ChatItemNotifier _chatItemNotifier;

  ChatNotifier(BuildContext context) {
    _chatController = context.read<ChatController>();
    _profileController = context.read<ProfileController>();
    _currentProfileNotifier = context.read<CurrentProfileNotifier>();
    _chatItemNotifier = context.read<ChatItemNotifier>();
  }

  List<Chat> _chats = [];
  bool _hasUnread = false;
  Map<String, Map<String, dynamic>> data = {};
  List<Chat> get chats => _chats;
  bool get hasUnread => _hasUnread;

  StreamSubscription<List<Chat>>? _chatSubscription;

  void init(String userId) {
    setLoading(true);
    _chatSubscription?.cancel();
    loadChats(userId);
    _chatSubscription = _chatController.watchChats(userId).listen(
      (newChats) {
        _chats = newChats;
        _hasUnread =
            newChats.any((chat) => chat.unread && userId != chat.lastSenderId);
        fetchProfiles(userId);
      },
      onError: (error) {
        setError(error.toString());
      },
    );
    setLoading(false);
  }

  void loadChats(String userId) async {
    _chats = await _chatController.getChats(userId);
    fetchProfiles(userId);
  }

  void fetchProfiles(String userId) async {
    List<Profile> profiles =
        await _profileController.getProfilesById(getProfilIds(userId));
    Map<String, Map<String, dynamic>> mapping = {};
    for (final profile in profiles) {
      mapping[profile.userId] = {'profile': profile};
    }

    for (final chat in chats) {
      final String participant =
          chat.participants.where((p) => p != userId).first;
      mapping[participant]?['chat'] = chat;
    }
    data = mapping;
    notifyListeners();
    setLoading(false);
  }

  Set<String> getProfilIds(String userId) {
    Set<String> profilIds = {};
    for (final chat in _chats) {
      profilIds.addAll(chat.participants);
    }
    profilIds.remove(userId);
    return profilIds;
  }

  Future<void> createChat(Chat chat) => runAsync(() async {
        await _chatController.createChat(chat);
      });

  Future<void> removeChat(String chatId) => runAsync(() async {
        await _chatController.removeChat(chatId);
      });

  Future<void> updateChat(Chat chat) => runAsync(() async {
        await _chatController.updateChat(chat.id, chat);
      });

  Future<void> markChatAsRead(Chat chat) => runAsync(() async {
        chat.unread = false;
        await updateChat(chat);
      });

  String? getChatIdByUser(String userId) {
    try {
      return _chats.firstWhere((chat) => chat.participants.contains(userId)).id;
    } catch (_) {
      return null;
    }
  }

  Future<Chat> getChatById(String chatId) async {
    return Future.delayed(
        Duration(microseconds: 100),
        () => _chats.firstWhere((chat) => chat.id == chatId,
            orElse: () => Chat(
                inserted: false,
                id: chatId,
                participants: chatId.split('::'),
                updatedAt: DateTime.now(),
                unread: false)));
  }

  String formatChatTimestamp(DateTime timestamp) {
    final now = DateTime.now();

    if (now.year == timestamp.year &&
        now.month == timestamp.month &&
        now.day == timestamp.day) {
      return "${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}";
    } else {
      return "${timestamp.day.toString().padLeft(2, '0')}.${timestamp.month.toString().padLeft(2, '0')}";
    }
  }

  String generateChatId(String recieverId, String userId) {
    return ([recieverId, userId]..sort()).join('::');
  }

  void openChat(BuildContext context, Profile profile) async {
    String chatId = generateChatId(
      profile.userId,
      _currentProfileNotifier.getProfileId(),
    );

    final chat = await getChatById(chatId);
    _chatItemNotifier.init(chat);
    if (context.mounted) {
      CustomBottomSheet.show(
          context,
          ChatDetailScreen(
              chatId: getChatIdByUser(profile.userId) ?? "",
              senderProfile: profile),
          1);
    }
  }

  @override
  void dispose() {
    _chatSubscription?.cancel();
    super.dispose();
  }
}
