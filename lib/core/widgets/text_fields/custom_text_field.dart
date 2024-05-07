// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter_clean_architecture_template/core/enum/text_field_type.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_color_theme.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_text_theme.dart';
import 'package:flutter_clean_architecture_template/core/theme/custom_theme.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String fieldName;
  final String hintText;
  final TextInputType? textInputType;
  final double bottomPadding;
  final bool obscureText;
  final bool readOnly;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final bool isRequired;
  final VoidCallback? onPressed;
  final double topPadding;
  final IconData? prefixIcon;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final TextFieldType textFieldType;

  const CustomTextField({
    super.key,
    required this.label,
    required this.fieldName,
    required this.hintText,
    this.textInputType,
    this.bottomPadding = 16,
    this.obscureText = false,
    this.readOnly = false,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.isRequired = false,
    this.onPressed,
    this.topPadding = 0,
    this.prefixIcon,
    this.maxLines = 1,
    this.inputFormatters,
    this.maxLength,
    this.onChanged,
    this.textFieldType = TextFieldType.Normal,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obsureText = false;

  @override
  void initState() {
    super.initState();
    if (widget.textFieldType == TextFieldType.Normal) {
      obsureText = widget.obscureText;
    } else {
      obsureText = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    final appColorTheme = Theme.of(context).extension<AppColorTheme>()!;

    return Container(
      margin: EdgeInsets.only(
        bottom: widget.bottomPadding,
        top: widget.topPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.label,
                style: appTextTheme.label,
              ),
              if (widget.isRequired)
                Text(
                  " *",
                  style: appTextTheme.label.copyWith(
                    color: appColorTheme.warning.shade500,
                  ),
                )
            ],
          ),
          const SizedBox(height: 8),
          FormBuilderTextField(
            style: appTextTheme.formInput,
            validator: widget.validator,
            name: widget.fieldName,
            controller: widget.controller,
            cursorColor: appColorTheme.primary,
            maxLines: widget.maxLines,
            keyboardType: TextInputType.text,
            obscureText: obsureText,
            readOnly: widget.readOnly,
            onTap: widget.onPressed,
            inputFormatters: widget.inputFormatters,
            maxLength: widget.maxLength,
            onChanged: widget.onChanged != null
                ? (val) => widget.onChanged!(val ?? "")
                : null,
            decoration: InputDecoration(
              border: getBorder(
                isError: false,
                colorTheme: appColorTheme,
              ),
              enabledBorder: getBorder(
                isError: false,
                colorTheme: appColorTheme,
              ),
              focusedBorder: getBorder(
                isError: false,
                colorTheme: appColorTheme,
              ),
              disabledBorder: getBorder(
                isError: false,
                colorTheme: appColorTheme,
              ),
              errorBorder: getBorder(
                isError: true,
                colorTheme: appColorTheme,
              ),
              focusedErrorBorder: getBorder(
                isError: true,
                colorTheme: appColorTheme,
              ),
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 12,
              ),
              errorStyle: appTextTheme.formhelper.copyWith(
                color: appColorTheme.feedback,
              ),
              counterText: "",
              hintText: widget.hintText,
              hintStyle: appTextTheme.formInput,
              prefixIcon: widget.prefixIcon != null
                  ? Icon(
                      widget.prefixIcon,
                      size: 19,
                      color: appColorTheme.gray.shade500,
                    )
                  : null,
              suffixIcon: widget.textFieldType == TextFieldType.Password
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          obsureText = !obsureText;
                        });
                      },
                      child: Icon(
                        obsureText
                            ? Icons.visibility_off
                            : Icons.remove_red_eye,
                        size: 19,
                        color: appColorTheme.gray.shade500,
                      ),
                    )
                  : Icon(
                      widget.suffixIcon,
                      size: 19,
                      color: appColorTheme.gray.shade500,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  InputBorder getBorder({
    required bool isError,
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
