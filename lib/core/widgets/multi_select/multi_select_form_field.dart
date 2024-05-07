import 'package:animations/animations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture_template/core/constants/locale_keys.dart';
import 'package:flutter_clean_architecture_template/core/model/form_options.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_color_theme.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_decoration_theme.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_text_theme.dart';
import 'package:flutter_clean_architecture_template/core/theme/custom_theme.dart';
import 'package:flutter_clean_architecture_template/core/utils/size_utils.dart';
import 'package:flutter_clean_architecture_template/core/utils/snackbar_utils.dart';
import 'package:flutter_clean_architecture_template/core/widgets/appbar/custom_app_bar.dart';
import 'package:flutter_clean_architecture_template/core/widgets/button/custom_rounded_button.dart';
import 'package:flutter_clean_architecture_template/core/widgets/multi_select/multi_select_form_controller.dart';
import 'package:flutter_clean_architecture_template/core/widgets/text_fields/search_text_field.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

part 'mutli_select_selection_view.dart';

class MultiSelectFormField extends StatefulWidget {
  final String fieldName;
  final String label;
  final String hintText;
  final bool isRequired;
  final ValueChanged<List>? onChanged;
  final List? initialValue;
  final List<FormOptions> options;
  final bool allowMultiSelect;
  final MultiSelectFormController? controller;
  final bool readOnly;
  final bool disabled;
  const MultiSelectFormField({
    super.key,
    required this.label,
    required this.hintText,
    String? fieldName,
    this.isRequired = false,
    this.onChanged,
    this.initialValue,
    required this.options,
    this.allowMultiSelect = true,
    this.controller,
    this.readOnly = false,
    this.disabled = false,
  }) : fieldName = fieldName ?? label;

  @override
  State<MultiSelectFormField> createState() => _MultiSelectFormFieldState();
}

class _MultiSelectFormFieldState<Type> extends State<MultiSelectFormField> {
  List _selectedItems = [];
  List<FormOptions> options = [];
  late MultiSelectFormController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? MultiSelectFormController();
    controller.addListener(updateOptions);
    controller.value = [...widget.options];
    _selectedItems = [...?widget.initialValue];
  }

  updateOptions() {
    setState(() {
      options = controller.value;
    });
  }

  @override
  void didUpdateWidget(covariant MultiSelectFormField oldWidget) {
    if (oldWidget.options != widget.options) {
      controller.value = widget.options;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.removeListener(updateOptions);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTextTheme = Theme.of(context).extension<AppTextTheme>()!;
    final appColorTheme = Theme.of(context).extension<AppColorTheme>()!;

    return AbsorbPointer(
      absorbing: widget.readOnly || widget.disabled,
      child: FormBuilderField<List>(
        name: widget.fieldName,
        validator: (value) {
          if ((value?.isNotEmpty ?? false) || !widget.isRequired) {
            return null;
          } else {
            return LocaleKeys.fieldCannotBeEmpty.tr(args: [widget.label]);
          }
        },
        initialValue: _selectedItems,
        builder: (FormFieldState<dynamic> field) {
          return OpenContainer(
            openBuilder: (context, action) {
              return _MultiSelectSelectionView(
                label: widget.label,
                items: options,
                selectedItems: _selectedItems,
                hintText: widget.hintText,
                allowMultiSelect: widget.allowMultiSelect,
                onChanged: (value) {
                  setState(() {
                    _selectedItems = value;
                  });
                  field.didChange(value);
                  if (widget.onChanged != null) {
                    widget.onChanged!(value);
                  }
                },
              );
            },
            openElevation: 0,
            closedElevation: 0,
            closedBuilder: (context, action) {
              return InkWell(
                onTap: () {
                  if (options.isNotEmpty) {
                    action();
                  } else {
                    SnackBarUtils.showErrorMessage(
                      context: context,
                      message: "No Options available",
                    );
                  }
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    errorText: field.errorText,
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
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    fillColor: widget.disabled
                        ? appColorTheme.gray.shade300
                        : Colors.transparent,
                    filled: widget.disabled,
                  ),
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 60),
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_selectedItems.isEmpty)
                          RichText(
                            text: TextSpan(
                              text: "Select ${widget.label}",
                              style: appTextTheme.label,
                              children: [
                                if (widget.isRequired)
                                  TextSpan(
                                    text: " *",
                                    style: appTextTheme.label.copyWith(
                                      color: appColorTheme.warning,
                                    ),
                                  )
                              ],
                            ),
                          ),
                        if (_selectedItems.isNotEmpty)
                          Text(
                            widget.allowMultiSelect
                                ? "${_selectedItems.length} ${widget.label} Selected"
                                : options
                                    .firstWhere(
                                        (e) => e.value == _selectedItems.first)
                                    .label,
                            style: appTextTheme.label.copyWith(
                              color: appColorTheme.gray.shade50,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  InputBorder getBorder({
    required bool isError,
    required AppColorTheme colorTheme,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: isError ? colorTheme.feedback : colorTheme.borderElement,
      ),
    );
  }
}
