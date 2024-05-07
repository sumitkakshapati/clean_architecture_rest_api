import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/core/constants/assets.dart';
import 'package:flutter_clean_architecture_template/core/widgets/images/custom_network_image.dart';

class CustomRoundedImage extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  final Widget? customPlaceHolder;
  final String fallBackImage;
  const CustomRoundedImage({
    super.key,
    required this.height,
    required this.image,
    required this.width,
    this.customPlaceHolder,
    this.fallBackImage = Assets.fallbackImage,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height > width ? height : width),
      child: CustomCachedNetworkImage(
        url: image,
        height: height,
        width: width,
        fit: BoxFit.cover,
        alignment: Alignment.center,
        customPlaceHolder: customPlaceHolder,
        placeholder: fallBackImage,
      ),
    );
  }
}
