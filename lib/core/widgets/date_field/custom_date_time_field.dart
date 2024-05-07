import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_color_theme.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_text_theme.dart';
import 'package:flutter_clean_architecture_template/core/theme/custom_theme.dart';
import 'package:flutter_clean_architecture_template/core/utils/form_validator.dart';
import 'package:flutter_clean_architecture_template/core/utils/size_utils.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomDateTimeField extends StatelessWidget {
  final String fieldName;
  final String label;
  final String hintText;
  final double bottomPadding;
  final double rightPadding;
  final double leftPadding;
  final bool isRequired;
  final ValueChanged<DateTime>? onChanged;
  final DateTime? initialValue;
  final InputType dateTimeInputType;
  final bool readOnly;
  final DateTime? maxDate;
  final DateTime? minDate;
  final DateTime? currentDate;
  const CustomDateTimeField({
    super.key,
    required this.label,
    required this.hintText,
    this.bottomPadding = 16,
    this.rightPadding = CustomTheme.pagePadding,
    this.leftPadding = CustomTheme.pagePadding,
    String? fieldName,
    this.isRequired = false,
    this.onChanged,
    this.initialValue,
    this.readOnly = false,
    this.dateTimeInputType = InputType.date,
    this.currentDate,
    this.maxDate,
    this.minDate,
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
          FormBuilderDateTimePicker(
            name: fieldName,
            initialValue: initialValue,
            onChanged: (value) {
              if (value != null && onChanged != null) {
                onChanged!(value);
              }
            },
            inputType: dateTimeInputType,
            style: appTextTheme.bodyNormalRegular.copyWith(
              color: appColorTheme.gray.shade900,
            ),
            initialDate:
                (maxDate?.isBefore(DateTime.now()) ?? false) ? maxDate : null,
            lastDate: maxDate,
            firstDate: minDate,
            enabled: !readOnly,
            validator: isRequired
                ? (value) => FormValidator.validateFieldNotEmpty(
                      value?.toString(),
                      label,
                    )
                : null,
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
              suffixIcon: Icon(
                CupertinoIcons.calendar,
                color: appColorTheme.gray.shade500,
              ),
              hintText: hintText,
              hintStyle: appTextTheme.formInput,
            ),
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
