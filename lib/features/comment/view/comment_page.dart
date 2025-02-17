import 'package:designhub/features/chat/widgets/section_chat_input.dart';
import 'package:designhub/features/comment/models/comment_item.dart';
import 'package:designhub/features/comment/widgets/comment_detail.dart';
import 'package:designhub/features/profile/models/profile_singleton.dart';
import 'package:designhub/shared/controller/controller.dart';
import 'package:flutter/material.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key, required this.postId});
  final String postId;
  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  TextEditingController newMessageController = TextEditingController();
  List<CommentItem>? comments;

  @override
  void dispose() {
    newMessageController.dispose();
    super.dispose();
  }

  void saveComment() {
    CommentItem newComment = createComment();
    newMessageController.clear();
    Controller().commentDB.addComment(widget.postId, newComment);
    setState(() {});
  }

  CommentItem createComment() {
    return CommentItem(
        profilId: ProfileSingleton().profile!.userId,
        text: newMessageController.text);
  }

  @override
  Widget build(BuildContext context) {
    comments = Controller().commentDB.getComments(widget.postId);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
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
          SizedBox(
            height: 250,
            width: double.infinity,
            child: ListView(
              children:
                  comments!.map((e) => CommentDetail(comment: e)).toList(),
            ),
          ),
          SizedBox(height: 16),
          SectionChatInput(
            handleNewMessage: saveComment,
            messageController: newMessageController,
          )
        ],
      ),
    );
  }
}
