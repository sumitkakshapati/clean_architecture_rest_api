import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  final String title;
  final Color? textColor;
  final Color? borderColor;
  final Function()? onPressed;
  final double horizontalPadding;
  final double verticalPadding;
  final double fontSize;
  final FontWeight fontWeight;

  const CustomOutlineButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.borderColor,
    this.textColor,
    this.horizontalPadding = 12,
    this.verticalPadding = 20,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w700,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Material(
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: verticalPadding, horizontal: horizontalPadding),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor ?? theme.primaryColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            title,
            style: textTheme.headlineSmall!.copyWith(
              fontWeight: fontWeight,
              fontSize: fontSize,
              color: textColor ?? theme.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
