import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/core/model/form_options.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_color_theme.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_text_theme.dart';
import 'package:flutter_clean_architecture_template/core/theme/custom_theme.dart';
import 'package:flutter_clean_architecture_template/core/utils/form_validator.dart';
import 'package:flutter_clean_architecture_template/core/utils/size_utils.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomDropDownField<Type> extends StatelessWidget {
  final String fieldName;
  final String label;
  final String hintText;
  final double bottomPadding;
  final double rightPadding;
  final double leftPadding;
  final List<FormOptions> options;
  final bool isRequired;
  final ValueChanged<Type>? onChanged;
  final Type? initialValue;
  final VoidCallback? onPressed;
  final bool readOnly;
  const CustomDropDownField({
    super.key,
    required this.label,
    required this.hintText,
    this.bottomPadding = 16,
    this.rightPadding = CustomTheme.pagePadding,
    this.leftPadding = CustomTheme.pagePadding,
    String? fieldName,
    this.isRequired = false,
    required this.options,
    this.onChanged,
    this.initialValue,
    this.onPressed,
    this.readOnly = false,
  }) : fieldName = fieldName ?? label;

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    final appColorTheme = Theme.of(context).extension<AppColorTheme>()!;

    return Container(
      margin: EdgeInsets.only(
        bottom: bottomPadding,
        left: leftPadding,
        right: rightPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label.isNotEmpty)
            RichText(
              text: TextSpan(
                text: label,
                style: appTextTheme.label,
                children: [
                  if (isRequired)
                    TextSpan(
                      text: " *",
                      style: appTextTheme.label.copyWith(
                        color: appColorTheme.feedback,
                      ),
                    )
                ],
              ),
            ),
          if (label.isNotEmpty) SizedBox(height: 6.hp),
          FormBuilderDropdown<Type>(
            name: fieldName,
            initialValue: initialValue,
            onTap: onPressed,
            onChanged: (value) {
              if (value != null && onChanged != null) {
                onChanged!(value);
              }
            },
            style: appTextTheme.bodyNormalRegular.copyWith(
              color: appColorTheme.gray.shade900,
            ),
            validator: isRequired
                ? (value) => FormValidator.validateFieldNotEmpty(
                      value?.toString(),
                      label,
                    )
                : null,
            enabled: !readOnly,
            decoration: InputDecoration(
              border: getBorder(
                colorTheme: appColorTheme,
              ),
              enabledBorder: getBorder(
                colorTheme: appColorTheme,
              ),
              focusedBorder: getBorder(
                colorTheme: appColorTheme,
              ),
              disabledBorder: getBorder(
                colorTheme: appColorTheme,
              ),
              errorBorder: getBorder(
                colorTheme: appColorTheme,
                isError: true,
              ),
              focusedErrorBorder: getBorder(
                colorTheme: appColorTheme,
                isError: true,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 12,
              ),
              errorStyle: appTextTheme.formhelper.copyWith(
                color: appColorTheme.feedback,
              ),
              fillColor:
                  readOnly ? appColorTheme.gray.shade200 : Colors.transparent,
              filled: readOnly,
              hintText: hintText,
              hintStyle: appTextTheme.formInput,
            ),
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: appColorTheme.gray.shade500,
            ),
            items: options
                .map(
                  (e) => DropdownMenuItem<Type>(
                    value: e.value,
                    child: Text(
                      e.label,
                      style: appTextTheme.bodyNormalRegular.copyWith(
                        color: appColorTheme.gray.shade900,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  InputBorder getBorder({
    bool isError = false,
    required AppColorTheme colorTheme,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(CustomTheme.borderRadius),
      borderSide: BorderSide(
        color: isError ? colorTheme.feedback : colorTheme.borderElement,
      ),
    );
  }
}
