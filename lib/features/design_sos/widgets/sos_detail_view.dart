import 'package:designhub/features/posts/models/post.dart';
import 'package:designhub/features/profile/models/profile.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class SosDetailView extends StatelessWidget {
  final Profile profile;
  final Post post;
  const SosDetailView({super.key, required this.post, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
        iconTheme: IconThemeData(color: DesignhubColors.black),
      ),
      body: PageView.builder(
        controller: PageController(initialPage: 0),
        itemCount: post.images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: PhotoView(
              backgroundDecoration:
                  BoxDecoration(color: DesignhubColors.transparent),
              imageProvider: NetworkImage(post.images[index]),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered,
            ),
          );
        },
      ),
    );
  }
}
