import 'dart:io';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final String imagePath;
  final Function callback;

  const ImageCard({
    super.key,
    required this.imagePath,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Image.file(
              File(imagePath),
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
              right: 8,
              top: 8,
              child: IconButton(
                  onPressed: () => callback(imagePath),
                  icon: Icon(Icons.delete)))
        ],
      ),
    );
  }
}
