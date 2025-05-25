import 'package:designhub/features/content/comment/controller/comment_controller.dart';
import 'package:designhub/features/content/comment/models/comment_item.dart';
import 'package:designhub/features/content/comment/widgets/comment_detail.dart';
import 'package:designhub/features/content/news/controller/news_controller.dart';
import 'package:designhub/features/content/news/models/news.dart';
import 'package:designhub/features/content/news/models/news_type.dart';
import 'package:designhub/features/socials/profile/controller/profile_controller.dart';
import 'package:designhub/features/socials/profile/models/profile.dart';
import 'package:designhub/shared/provider/base_provider.dart';
import 'package:designhub/features/socials/profile/provider/current_profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentNotifier extends BaseUiProvider {
  final String postId;
  final String postCreatorId;

  List<Profile> _profiles = [];
  List<CommentItem> _comments = [];

  String _messageText = "";
  late final TextEditingController messageController;

  late final NewsController _newsController;
  late final CommentController _commentController;
  late final ProfileController _profileController;
  late final CurrentProfileNotifier _loginNotifier;

  CommentNotifier(this.postId, this.postCreatorId, BuildContext context) {
    _newsController = context.read<NewsController>();
    _commentController = context.read<CommentController>();
    _profileController = context.read<ProfileController>();
    _loginNotifier = context.read<CurrentProfileNotifier>();

    messageController = TextEditingController();
    _loadComments();
  }

  List<CommentItem> get comments => _comments;
  String get messageText => _messageText;

  void updateMessage(String value) {
    _messageText = value;
    notifyListeners();
  }

  Future<void> _loadComments() => runAsync(() async {
        final fetchedComments = await _commentController.getComments(postId);
        _comments = fetchedComments;

        final profileIds = _comments.map((e) => e.userId).toSet();
        _profiles = await _profileController.getProfilesById(profileIds);

        notifyListeners();
      });

  Future<void> saveComment() => runAsync(() async {
        final newComment = _createComment();
        await _commentController.addComment(postId, newComment);
        _newsController.addNews(_createNewsItem());

        _messageText = "";
        messageController.clear();

        await _loadComments();
      });

  CommentItem _createComment() {
    final currentProfile = _loginNotifier.getProfile();

    if (!_profiles.any((p) => p.userId == currentProfile.userId)) {
      _profiles.add(currentProfile);
    }

    return CommentItem(
        userId: currentProfile.userId,
        message: _messageText,
        createdAt: DateTime.now(),
        id: "");
  }

  News _createNewsItem() {
    final currentProfile = _loginNotifier.getProfile();
    final now = DateTime.now();

    return News(
      creatorId: currentProfile.userId,
      profilId: postCreatorId,
      postId: postId,
      type: NewsType.comment,
      read: false,
      date: "${now.day}.${now.month}.${now.year}",
    );
  }

  Profile getProfile(String profileId) {
    return _profiles.firstWhere((p) => p.userId == profileId);
  }

  List<Widget> buildCommentDetails() => _comments.map((c) {
        return CommentDetail(comment: c, profile: getProfile(c.userId));
      }).toList();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
