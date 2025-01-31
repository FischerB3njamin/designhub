import 'dart:io';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final String imagePath;
  final Function callback;
  const ImageCard({super.key, required this.imagePath, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Stack(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.file(
              File(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          // removebutton
          Positioned(
              right: 16,
              top: 16,
              child: IconButton(
                  onPressed: () => callback(imagePath),
                  icon: Icon(Icons.delete)))
        ],
      ),
    );
  }
}
