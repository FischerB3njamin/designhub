import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

class ImagePickerField extends StatelessWidget {
  final String title;
  final String imagePath;
  final File? imageFile;
  final VoidCallback onPick;

  const ImagePickerField({
    super.key,
    required this.title,
    required this.imagePath,
    required this.imageFile,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextTheme.of(context)
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              GestureDetector(
                onTap: onPick,
                child: imageFile != null
                    ? Image.file(
                        imageFile!,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      )
                    : (imagePath.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: imagePath,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,
                          )
                        : Container(
                            width: double.infinity,
                            height: 200,
                            color: DesignhubColors.grey300,
                            alignment: Alignment.center,
                            child: Icon(Icons.image,
                                size: 40, color: DesignhubColors.grey700),
                          )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
