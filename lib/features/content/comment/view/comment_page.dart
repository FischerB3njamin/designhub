import 'package:designhub/features/content/comment/widgets/section_comment_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:designhub/features/content/comment/provider/comment_notifier.dart';

class CommentPage extends StatelessWidget {
  const CommentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final commentNotifier = context.watch<CommentNotifier>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Comments'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: commentNotifier.buildCommentDetails(),
                  ),
                ),
                SectionCommentInput(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
