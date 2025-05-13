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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            spacing: 16,
            children: [
              SectionPostDetail(post: notifier.post!),
              _buildImageGallery(notifier.post!),
              SizedBox(height: 32),
            ],
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
            padding: const EdgeInsets.all(8.0),
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(32)),
              child: Image.file(
                File(post.images[index]),
                width: MediaQuery.of(context).size.width - 48,
                fit: BoxFit.fitHeight,
              ),
            ),
          );
        },
      ),
    );
  }
}
