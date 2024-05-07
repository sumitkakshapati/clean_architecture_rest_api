// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_accent_color.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_color.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_material_color.dart';

class AppColorTheme extends ThemeExtension<AppColorTheme> {
  final AppMaterialColor primary;
  final MaterialColor gray;
  final AppAccentColor feedback;
  final AppAccentColor info;
  final AppAccentColor warning;
  final Color borderElement;
  final Color borderLayout;
  final Color highlight;
  final Color backgroundColor;

  const AppColorTheme({
    required this.primary,
    required this.gray,
    required this.borderElement,
    required this.borderLayout,
    required this.highlight,
    required this.backgroundColor,
    required this.feedback,
    required this.info,
    required this.warning,
  });

  factory AppColorTheme.light() {
    return AppColorTheme(
      primary: AppColors.primaryLight,
      gray: AppColors.grey,
      backgroundColor: AppColors.backgroundColor,
      borderElement: AppColors.borderElement,
      borderLayout: AppColors.borderLayout,
      highlight: AppColors.highlightColor,
      feedback: AppColors.feedback,
      info: AppColors.info,
      warning: AppColors.warning,
    );
  }

  @override
  ThemeExtension<AppColorTheme> copyWith({
    AppMaterialColor? primary,
    MaterialColor? gray,
    Color? danger,
    Color? borderElement,
    Color? borderLayout,
    Color? highlight,
    Color? backgroundColor,
    AppAccentColor? feedback,
    AppAccentColor? warning,
    AppAccentColor? info,
  }) {
    return AppColorTheme(
      primary: primary ?? this.primary,
      gray: gray ?? this.gray,
      borderElement: borderElement ?? this.borderElement,
      borderLayout: borderLayout ?? this.borderLayout,
      highlight: highlight ?? this.highlight,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      feedback: feedback ?? this.feedback,
      info: info ?? this.info,
      warning: warning ?? this.warning,
    );
  }

  @override
  ThemeExtension<AppColorTheme> lerp(
      covariant ThemeExtension<AppColorTheme>? other, double t) {
    return this;
  }
}
