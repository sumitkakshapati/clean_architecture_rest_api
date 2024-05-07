import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_color_theme.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_text_theme.dart';

class SearchtextField extends StatelessWidget {
  final TextEditingController controller;
  final void Function()? onSearchPressed;
  final String hintText;
  final bool isFilled;

  const SearchtextField({
    super.key,
    required this.controller,
    this.onSearchPressed,
    required this.hintText,
    this.isFilled = false,
  });

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    final appColorTheme = Theme.of(context).extension<AppColorTheme>()!;

    return TextFormField(
      style: appTextTheme.formInput,
      controller: controller,
      cursorColor: appColorTheme.primary,
      maxLines: 1,
      textInputAction: TextInputAction.search,
      keyboardType: TextInputType.text,
      onEditingComplete: onSearchPressed,
      onTapOutside: (event) {
        onSearchPressed?.call();
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: appColorTheme.gray),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: appColorTheme.backgroundColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: appColorTheme.backgroundColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: appColorTheme.backgroundColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: appColorTheme.backgroundColor),
        ),
        fillColor: isFilled ? appColorTheme.gray.shade200 : Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 17),
        hintText: hintText,
        prefixIcon: Icon(
          CupertinoIcons.search,
          size: 22,
          color: appColorTheme.gray,
        ),
        hintStyle: TextStyle(
          color: appColorTheme.gray,
          fontSize: 15,
          letterSpacing: 0.6,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
