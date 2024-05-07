// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/core/animations/tap_effect.dart';
import 'package:flutter_clean_architecture_template/core/constants/assets.dart';
import 'package:flutter_clean_architecture_template/core/enum/border_type.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_color_theme.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_text_theme.dart';
import 'package:flutter_clean_architecture_template/core/utils/size_utils.dart';
import 'package:flutter_clean_architecture_template/core/widgets/images/custom_network_image.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String description;
  final void Function()? onPressed;
  final IconData? icon;
  final EdgeInsets? margin;
  final String? imageUrl;
  final Widget? suffix;
  final Color? subtitleTextColor;
  final double horizontalPadding;
  final String fallbackImage;
  final double bottomMargin;
  final Widget? prefix;
  final CustomBorderType borderType;
  final TextStyle? titleStyle;
  final double verticalPadding;

  const CustomListTile({
    super.key,
    required this.title,
    this.description = "",
    this.onPressed,
    this.icon,
    this.margin,
    this.imageUrl,
    this.suffix,
    this.subtitleTextColor,
    this.horizontalPadding = 10,
    this.fallbackImage = Assets.fallbackImage,
    this.bottomMargin = 10,
    this.prefix,
    this.titleStyle,
    this.borderType = CustomBorderType.All,
    this.verticalPadding = 8,
  });

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    final appColorTheme = Theme.of(context).extension<AppColorTheme>()!;

    return Container(
      margin: margin ?? EdgeInsets.only(bottom: bottomMargin),
      child: Material(
        type: MaterialType.transparency,
        child: TapEffect(
          enable: onPressed != null,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(6),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: verticalPadding.hp,
                horizontal: horizontalPadding,
              ),
              decoration: BoxDecoration(
                border: switch (borderType) {
                  CustomBorderType.All => Border.all(
                      color: appColorTheme.borderLayout,
                      width: 1,
                    ),
                  CustomBorderType.BottomOnly => Border(
                      bottom: BorderSide(
                        color: appColorTheme.borderLayout,
                        width: 1,
                      ),
                    ),
                  CustomBorderType.None => null,
                },
                borderRadius: borderType == CustomBorderType.All
                    ? BorderRadius.circular(6)
                    : null,
              ),
              child: Row(
                children: [
                  if (prefix != null)
                    Container(
                      padding: EdgeInsets.only(right: 16.wp),
                      child: prefix!,
                    ),
                  if (icon != null)
                    Container(
                      padding: const EdgeInsets.all(2),
                      margin: EdgeInsets.only(right: 12.wp),
                      child: Icon(
                        icon,
                        color: appColorTheme.gray,
                        size: 28,
                      ),
                    ),
                  if (imageUrl != null)
                    Container(
                      margin: EdgeInsets.only(right: 12.wp),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: CustomCachedNetworkImage(
                          url: imageUrl!,
                          placeholder: fallbackImage,
                          fit: BoxFit.cover,
                          height: 45.wp,
                          width: 45.wp,
                        ),
                      ),
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (title.isNotEmpty)
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: titleStyle ?? appTextTheme.label,
                          ),
                        if (title.isNotEmpty && description.isNotEmpty)
                          SizedBox(height: 4.hp),
                        if (description.isNotEmpty)
                          Text(
                            description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: appTextTheme.bodySmallRegular.copyWith(
                              height: 1.35,
                              color: subtitleTextColor,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (suffix != null) suffix!,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
