import 'package:designhub/features/chat/controller/chat_controller.dart';
import 'package:designhub/features/chat/models/chat.dart';
import 'package:designhub/features/chat/widgets/chat_view.dart';
import 'package:designhub/features/news/controller/news_controller.dart';
import 'package:designhub/features/news/models/news.dart';
import 'package:designhub/features/news/view/news_view.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:flutter/material.dart';

class ChatNewsPage extends StatefulWidget {
  final Function callback;
  const ChatNewsPage({
    super.key,
    required this.callback,
  });

  @override
  State<ChatNewsPage> createState() => _ChatNewsPageState();
}

class _ChatNewsPageState extends State<ChatNewsPage> {
  bool isLoading = true;
  NewsController newsController = NewsController();
  ChatController chatController = ChatController();
  ProfileController profileController = ProfileController();
  List<News>? news;
  List<Chat>? chats;
  List<Profile>? profiles;
  late Profile currentUser;
  @override
  void initState() {
    super.initState();
    currentUser = profileController.getCurrentProfile();
    _loadNews();
    _loadChats();
  }

  _loadNews() async {
    news = await newsController.getNews(currentUser.userId);
    _loadProfiles();
  }

  _loadChats() async {
    chats = await chatController.getChats();
    _loadProfiles();
  }

  _loadProfiles() async {
    if (chats != null && news != null) {
      Set<String> profileIds = {};
      profileIds.addAll(news!.map((a) => a.creatorId).toSet());
      profileIds.addAll(chats!
          .map((a) => convertParticipants(a.participants, currentUser))
          .toSet());
      profileController.getProfilesById(profileIds).then((value) {
        profiles = value;
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  String convertParticipants(List<String> participants, Profile currentUser) {
    return participants.firstWhere((e) => e != currentUser.userId);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: NewsView(
              smallView: true,
              news: news!,
              profiles: profiles!,
              callback: widget.callback,
            ),
          ),
          Expanded(
            flex: 3,
            child: ChatView(
                isSmallView: true,
                chats: chats!,
                profiles: profiles!,
                currentUser: currentUser),
          )
        ],
      ),
    );
  }
}
