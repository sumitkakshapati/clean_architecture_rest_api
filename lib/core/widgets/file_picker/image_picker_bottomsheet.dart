import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/core/constants/assets.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_text_theme.dart';
import 'package:flutter_clean_architecture_template/core/utils/size_utils.dart';
import 'package:flutter_clean_architecture_template/core/widgets/list_tile/custom_list_tile.dart';
import 'package:flutter_clean_architecture_template/core/wrapper/bottomsheet_wrapper.dart';
import 'package:flutter_svg/svg.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  final Function onGalleryPressed;
  final File? imagePath;
  final String? imageUrl;
  final Function? onCameraPressed;
  final bool? showCameraOption;
  final VoidCallback onDeletePressed;

  const ImagePickerBottomSheet({
    super.key,
    this.onCameraPressed,
    required this.onGalleryPressed,
    this.showCameraOption = true,
    this.imagePath,
    this.imageUrl,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return BottomSheetWrapper(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (showCameraOption!)
            CustomListTile(
              prefix: SvgPicture.asset(
                SvgAssets.camera,
                height: 18,
                width: 18,
              ),
              title: "Take Photo",
              titleStyle: appTextTheme.bodySmallMedium.copyWith(
                fontWeight: FontWeight.w400,
              ),
              onPressed: () => onCameraPressed!(),
            ),
          CustomListTile(
            prefix: SvgPicture.asset(
              SvgAssets.gallery,
              height: 18,
              width: 18,
            ),
            title: "Select from Gallery",
            titleStyle: appTextTheme.bodySmallMedium.copyWith(
              fontWeight: FontWeight.w400,
            ),
            onPressed: () => onGalleryPressed(),
          ),
          SizedBox(height: 6.hp),
        ],
      ),
    );
  }
}
