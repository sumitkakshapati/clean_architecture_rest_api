import 'package:flutter/material.dart';

class CustomAssetRoundedImage extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  const CustomAssetRoundedImage({
    super.key,
    required this.height,
    required this.image,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height > width ? height : width),
      child: Image.asset(
        image,
        height: height,
        width: width,
        fit: BoxFit.cover,
        alignment: Alignment.center,
      ),
    );
  }
}
