import 'dart:io';

import 'package:designhub/features/posts/provider/post_new_notifier.dart';
import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/posts/widgets/section_post_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionOverview extends StatelessWidget {
  const SectionOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.read<NewPostNotifier>();
    return Padding(
      padding: EdgeInsets.all(16),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
              child: Column(
                children: [
                  SectionPostDetail(post: notifier.post!),
                  _buildImageGallery(notifier.post!),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageGallery(Post post) {
    return SizedBox(
      height: 600,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: post.images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.file(
              File(post.images[index]),
              width: MediaQuery.of(context).size.width - 32 > 400
                  ? 400
                  : MediaQuery.of(context).size.width - 32,
              fit: BoxFit.fitHeight,
            ),
          );
        },
      ),
    );
  }
}
