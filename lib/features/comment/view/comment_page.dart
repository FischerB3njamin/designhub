import 'package:designhub/features/chat/widgets/section_chat_input.dart';
import 'package:designhub/features/comment/controller/comment_controller.dart';
import 'package:designhub/features/comment/models/comment_item.dart';
import 'package:designhub/features/comment/widgets/comment_detail.dart';
import 'package:designhub/features/profile/controller/profile_controller.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:flutter/material.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key, required this.postId});
  final String postId;
  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  CommentController commentController = CommentController();
  ProfileController profileController = ProfileController();
  TextEditingController newMessageController = TextEditingController();
  List<CommentItem>? comments;
  List<Profile>? profiles;

  @override
  void dispose() {
    newMessageController.dispose();
    super.dispose();
  }

  void saveComment() {
    CommentItem newComment = createComment();
    newMessageController.clear();
    commentController.addComment(widget.postId, newComment);
    setState(() {});
  }

  CommentItem createComment() {
    profiles!.add(profileController.getCurrentProfile());
    return CommentItem(
        profilId: profileController.getCurrentProfile().userId,
        text: newMessageController.text);
  }

  @override
  void initState() {
    commentController.getComments(widget.postId).then((result) {
      comments = result;

      Set<String> profileIds = result.map((e) => e.profilId).toSet();

      if (profileIds.isNotEmpty) {
        profileController.getProfilesById(profileIds).then((value) {
          profiles = value;
          setState(() {});
          return;
        });
      }

      profiles = [];
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return comments == null || profiles == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Comments",
                      style: TextTheme.of(context).headlineLarge,
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: comments!
                        .map(
                          (e) => CommentDetail(
                            comment: e,
                            profile: profiles!.firstWhere(
                                (profile) => profile.userId == e.profilId),
                          ),
                        )
                        .toList(),
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: SectionChatInput(
                    handleNewMessage: saveComment,
                    messageController: newMessageController,
                  ),
                )
              ],
            ),
          );
  }
}
