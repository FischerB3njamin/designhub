import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class ImagePickerField extends StatelessWidget {
  final String title;
  final String? imagePath;
  final File? imageFile;
  final VoidCallback onPick;

  const ImagePickerField({
    super.key,
    required this.title,
    required this.imagePath,
    required this.imageFile,
    required this.onPick,
  });

  bool get _hasValidUrl =>
      imagePath != null &&
      imagePath!.trim().isNotEmpty &&
      Uri.tryParse(imagePath!)?.hasAbsolutePath == true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onPick,
          child: Container(
            width: double.infinity,
            height: 200,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: DesignhubColors.grey300,
              borderRadius: BorderRadius.circular(30),
            ),
            child: _buildImage(),
          ),
        ),
      ],
    );
  }

  Widget _buildImage() {
    if (imageFile != null) {
      return Image.file(
        imageFile!,
        fit: BoxFit.cover,
      );
    } else if (_hasValidUrl) {
      return CachedNetworkImage(
        imageUrl: imagePath!,
        fit: BoxFit.cover,
        placeholder: (context, url) =>
            Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Center(
            child: Icon(Icons.broken_image, color: DesignhubColors.grey700)),
      );
    } else {
      return Center(
        child: Icon(Icons.image, size: 40, color: DesignhubColors.grey700),
      );
    }
  }
}
