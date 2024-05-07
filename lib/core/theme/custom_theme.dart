import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture_template/core/constants/fonts.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_color.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_color_theme.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_decoration_theme.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_text_theme.dart';
import 'package:flutter_clean_architecture_template/core/utils/color_utils.dart';

class CustomTheme {
  static const double pagePadding = 20;
  static const double pageTopPadding = 24;
  static const double cardPadding = 16;
  static const double borderRadius = 4;
  static const double cardBorderRadius = 8;
  static const double cardBottomMargin = 24;
  static const double spaceBetween = 12;

  static const LinearGradient primaryLinearGradient = LinearGradient(
    colors: [
      Color(0xFF424176),
      Color(0xFFBAB5FE),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static ThemeData get lightTheme => ThemeData(
        primaryColor: AppColors.primaryLight,
        primarySwatch:
            ColorUtils.generateMaterialColor(color: AppColors.primaryLight),
        useMaterial3: false,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedLabelStyle: AppTextTheme.light().navBar,
          selectedItemColor: AppColors.primaryLight.shade400,
          unselectedLabelStyle: AppTextTheme.light().navBar,
          unselectedItemColor: AppColors.grey.shade400,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          elevation: 0,
          backgroundColor: AppColors.backgroundColor,
        ),
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColors.primaryLight.shade500,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
        ),
        scaffoldBackgroundColor: AppColors.backgroundColor,
        fontFamily: Fonts.inter,
        iconTheme: IconThemeData(
          color: AppColors.primaryLight,
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: AppColors.grey.shade200,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryLight.shade500,
        ),
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          side: BorderSide(color: AppColors.primaryLight),
        ),
        expansionTileTheme: ExpansionTileThemeData(
          iconColor: AppColors.primaryLight,
          childrenPadding: EdgeInsets.zero,
          tilePadding: const EdgeInsets.symmetric(
            horizontal: CustomTheme.pagePadding,
          ),
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(CustomTheme.borderRadius),
            ),
          ),
        ),
        splashColor: AppColors.primaryLight.shade400.withOpacity(0.4),
        dividerColor: Colors.transparent,
        tabBarTheme: TabBarTheme(
          labelColor: AppColors.primaryLight,
          labelStyle: AppTextTheme.light().sectionHeader,
          unselectedLabelColor: AppColors.grey.shade600,
          unselectedLabelStyle: AppTextTheme.light().bodyLargeRegular,
          indicatorColor: AppColors.primaryLight.shade500,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.primaryLight.shade500,
                width: 2,
              ),
            ),
          ),
        ),
        extensions: [
          AppColorTheme.light(),
          AppTextTheme.light(),
          AppDecorationTheme.light(),
        ],
      );
}
