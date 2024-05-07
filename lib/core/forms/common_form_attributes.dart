import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture_template/core/enum/text_field_type.dart';
import 'package:flutter_clean_architecture_template/core/model/form_options.dart';
import 'package:flutter_clean_architecture_template/core/widgets/forms/app_form_builder.dart';
import 'package:flutter_clean_architecture_template/core/widgets/forms/app_form_controller.dart';
import 'package:flutter_clean_architecture_template/core/widgets/multi_select/multi_select_form_controller.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

part 'checkbox_form_attributes.dart';
part 'date_time_form_attributes.dart';
part 'dropdown_form_attribute.dart';
part 'multi_select_form_attribute.dart';
part 'radio_form_attributes.dart';
part 'single_select_form_attributes.dart';
part 'switch_form_attribute.dart';
part 'textfield_form_attributes.dart';
part 'image_picker_form_attributes.dart';

sealed class CommonFormAttributes<Type> {
  final ValueChanged<Type>? onChanged;
  final Type? initialValue;
  final String label;
  final String fieldName;

  const CommonFormAttributes({
    this.onChanged,
    required this.initialValue,
    required this.label,
    required this.fieldName,
  });

  Widget build() {
    return AppFormBuilder(formAttributes: this);
  }
}

extension FormAttributeListExpension on List<CommonFormAttributes> {
  List<Widget> build() {
    return map((e) => AppFormBuilder(formAttributes: e)).toList();
  }
}
