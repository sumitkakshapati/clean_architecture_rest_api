import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/core/constants/locale_keys.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_color_theme.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_text_theme.dart';
import 'package:flutter_clean_architecture_template/core/utils/size_utils.dart';

showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const _LoadingDialog(),
  );
}

class _LoadingDialog extends StatelessWidget {
  const _LoadingDialog();

  @override
  Widget build(BuildContext context) {
    final appColorTheme = Theme.of(context).extension<AppColorTheme>()!;
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    return PopScope(
      canPop: false,
      child: Dialog(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoActivityIndicator(
                color: appColorTheme.primary,
                radius: 16,
              ),
              SizedBox(height: 14.hp),
              Text(
                LocaleKeys.loading.tr(),
                style: appTextTheme.bodyNormalMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
