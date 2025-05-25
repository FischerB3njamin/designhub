import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageGalleryScreen extends StatelessWidget {
  final List<String> images;
  final int initialIndex;
  final String title;

  const ImageGalleryScreen({
    super.key,
    required this.images,
    required this.initialIndex,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        iconTheme: IconThemeData(color: DesignhubColors.black),
      ),
      body: PageView.builder(
        controller: PageController(initialPage: initialIndex),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 12.0), // Adding space here
            child: PhotoView(
              backgroundDecoration:
                  BoxDecoration(color: DesignhubColors.transparent),
              imageProvider: NetworkImage(images[index]),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered,
            ),
          );
        },
      ),
    );
  }
}
