import 'package:flutter/material.dart';

class AvatarBigCircle extends StatelessWidget {
  const AvatarBigCircle({
    super.key,
    required this.imagePath,
    required this.height,
    required this.width,
  });

  final String imagePath;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: Image.network(imagePath, fit: BoxFit.cover),
    );
  }
}
