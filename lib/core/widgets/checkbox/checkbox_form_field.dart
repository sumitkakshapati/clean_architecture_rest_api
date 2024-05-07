import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_color_theme.dart';
import 'package:flutter_clean_architecture_template/core/theme/app_text_theme.dart';
import 'package:flutter_clean_architecture_template/core/widgets/forms/app_form_controller.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CheckBoxFormField extends StatefulWidget {
  final String label;
  final String fieldName;
  final bool initialValue;
  final ValueChanged<bool>? onChanged;
  final bool showBorder;
  final double bottomPadding;
  final double topPadding;
  final AppFormController<bool>? controller;

  const CheckBoxFormField({
    super.key,
    required this.label,
    required this.fieldName,
    this.initialValue = false,
    this.onChanged,
    this.controller,
    this.topPadding = 0,
    this.bottomPadding = 20,
    this.showBorder = true,
  });

  @override
  State<CheckBoxFormField> createState() => _CheckBoxFormFieldState();
}

class _CheckBoxFormFieldState extends State<CheckBoxFormField> {
  final GlobalKey<FormBuilderFieldState> _formKey =
      GlobalKey<FormBuilderFieldState>();

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_onChangedListener);
  }

  _onChangedListener() {
    _formKey.currentState?.didChange(widget.controller?.value);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onChangedListener);
    super.dispose();
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
      alignment: Alignment.center,
      constraints: const BoxConstraints(minHeight: 50),
      child: FormBuilderField<bool>(
          name: widget.fieldName,
          key: _formKey,
          initialValue: widget.initialValue,
          builder: (FormFieldState<bool> field) {
            return GestureDetector(
              onTap: () {
                if (widget.controller != null) {
                  widget.controller!.value = field.value ?? false;
                }
                field.didChange(!(field.value ?? false));
              },
              child: Row(
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: Checkbox(
                      value: field.value ?? false,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(
                          width: 1,
                          color: appColorTheme.gray,
                        ),
                      ),
                      onChanged: (value) {
                        field.didChange(value);
                        if (widget.controller != null) {
                          widget.controller!.value = field.value ?? false;
                        }
                        if (widget.onChanged != null) {
                          widget.onChanged!(value!);
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.label,
                    style: appTextTheme.label.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            );
          }),
    );
  }
}
