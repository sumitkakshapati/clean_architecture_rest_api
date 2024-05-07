import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_color_theme.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_decoration_theme.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_text_theme.dart';
import 'package:flutter_clean_architecture_template/core/theme/custom_theme.dart';
import 'package:flutter_clean_architecture_template/core/utils/size_utils.dart';
import 'package:flutter_clean_architecture_template/core/widgets/button/custom_icon_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leadingIcon;
  final Widget? centerWidget;
  final List<Widget> actions;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;
  final Color? tabBackgroundColor;
  final String? title;
  final TextStyle? titleStyle;
  final bool showBottomBorder;
  final Function()? onBackPressed;
  final bool showBackButton;
  final bool centerMiddle;
  final double? leftPadding;
  final double? rightPadding;
  final double topPadding;
  final bool showShadow;
  final Color? backButtonColor;
  const CustomAppBar({
    super.key,
    this.centerWidget,
    this.leadingIcon,
    this.bottom,
    this.backgroundColor,
    this.tabBackgroundColor,
    this.title,
    this.titleStyle,
    this.actions = const [],
    this.showBottomBorder = true,
    this.onBackPressed,
    this.centerMiddle = false,
    this.showBackButton = true,
    this.leftPadding,
    this.rightPadding,
    this.topPadding = 4,
    this.showShadow = true,
    this.backButtonColor,
  });

  Widget? getLeadingIcon(BuildContext context) {
    bool canPop = Navigator.of(context).canPop();
    final appColorTheme = Theme.of(context).extension<AppColorTheme>()!;
    if (leadingIcon != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [leadingIcon!],
      );
    } else {
      if (showBackButton && canPop) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconButton(
              onPressed: () {
                Navigator.of(context).maybePop();
              },
              padding: 2,
              icon: Icons.arrow_back,
              iconColor: backButtonColor ?? appColorTheme.primary.shade400,
            ),
          ],
        );
      } else {
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    final appColorTheme = Theme.of(context).extension<AppColorTheme>()!;
    final appDecorationTheme =
        Theme.of(context).extension<AppDecorationTheme>()!;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          if (showShadow) appDecorationTheme.e1,
        ],
        border: showBottomBorder
            ? Border(
                bottom: BorderSide(
                  width: 1,
                  color: appColorTheme.borderLayout,
                ),
              )
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.only(
                left: leftPadding ?? CustomTheme.pagePadding.wp,
                right: rightPadding ?? 10.wp,
                top: MediaQuery.of(context).padding.top + topPadding,
              ),
              decoration: BoxDecoration(
                color: backgroundColor ?? theme.scaffoldBackgroundColor,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 56),
                child: NavigationToolbar(
                  leading: getLeadingIcon(context),
                  middle: title != null
                      ? Text(
                          title!,
                          style: titleStyle ?? appTextTheme.pageHeader,
                        )
                      : centerWidget,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: actions,
                  ),
                  centerMiddle: centerMiddle,
                  middleSpacing: NavigationToolbar.kMiddleSpacing,
                ),
              ),
            ),
          ),
          if (bottom != null)
            Container(
              color: tabBackgroundColor,
              child: bottom!,
            )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(160);
}
