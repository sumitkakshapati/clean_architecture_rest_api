import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/core/forms/common_form_attributes.dart';
import 'package:flutter_clean_architecture_template/core/utils/form_validator.dart';
import 'package:flutter_clean_architecture_template/core/widgets/checkbox/checkbox_form_field.dart';
import 'package:flutter_clean_architecture_template/core/widgets/date_field/custom_date_time_field.dart';
import 'package:flutter_clean_architecture_template/core/widgets/dropdown/custom_dropdown_field.dart';
import 'package:flutter_clean_architecture_template/core/widgets/file_picker/form_image_picker.dart';
import 'package:flutter_clean_architecture_template/core/widgets/multi_select/multi_select_form_field.dart';
import 'package:flutter_clean_architecture_template/core/widgets/text_fields/custom_text_field.dart';

class AppFormBuilder extends StatelessWidget {
  final CommonFormAttributes formAttributes;
  const AppFormBuilder({required this.formAttributes, super.key});

  @override
  Widget build(BuildContext context) {
    return switch (formAttributes) {
      TextFieldFormAttribute() => CustomTextField(
          label: formAttributes.label,
          hintText: (formAttributes as TextFieldFormAttribute).hintText,
          fieldName: (formAttributes as TextFieldFormAttribute).fieldName,
          controller: (formAttributes as TextFieldFormAttribute).controller,
          isRequired: (formAttributes as TextFieldFormAttribute).isRequired,
          onPressed: (formAttributes as TextFieldFormAttribute).onTap,
          validator: (formAttributes as TextFieldFormAttribute).validator ??
              ((formAttributes as TextFieldFormAttribute).isRequired
                  ? (value) => FormValidator.validateFieldNotEmpty(
                      value, (formAttributes as TextFieldFormAttribute).label)
                  : null),
          prefixIcon: (formAttributes as TextFieldFormAttribute).prefix,
          suffixIcon: (formAttributes as TextFieldFormAttribute).suffix,
          maxLines: (formAttributes as TextFieldFormAttribute).maxLines,
          readOnly: (formAttributes as TextFieldFormAttribute).readOnly,
          textInputType:
              (formAttributes as TextFieldFormAttribute).keyboardType,
          inputFormatters:
              (formAttributes as TextFieldFormAttribute).inputFormatters,
          obscureText: (formAttributes as TextFieldFormAttribute).obscure,
          onChanged: (formAttributes as TextFieldFormAttribute).onChanged,
          maxLength: (formAttributes as TextFieldFormAttribute).maxLength,
          textFieldType:
              (formAttributes as TextFieldFormAttribute).textFieldType,
          bottomPadding:
              (formAttributes as TextFieldFormAttribute).bottomPadding,
          topPadding: (formAttributes as TextFieldFormAttribute).topPadding,
        ),
      DropDownFormAttribute() => CustomDropDownField(
          label: (formAttributes as DropDownFormAttribute).label,
          hintText: (formAttributes as DropDownFormAttribute).hintText,
          options: (formAttributes as DropDownFormAttribute).options,
          isRequired: (formAttributes as DropDownFormAttribute).isRequired,
          fieldName: (formAttributes as DropDownFormAttribute).fieldName,
          initialValue: (formAttributes as DropDownFormAttribute).initialValue,
          onPressed: (formAttributes as DropDownFormAttribute).onPressed,
          onChanged: (formAttributes as DropDownFormAttribute).onChanged,
          readOnly: (formAttributes as DropDownFormAttribute).readOnly,
        ),
      DateTimeFormAttribute() => CustomDateTimeField(
          label: (formAttributes as DateTimeFormAttribute).label,
          hintText: (formAttributes as DateTimeFormAttribute).hintText,
          isRequired: (formAttributes as DateTimeFormAttribute).isRequired,
          fieldName: (formAttributes as DateTimeFormAttribute).fieldName,
          initialValue: (formAttributes as DateTimeFormAttribute).initialValue,
          onChanged: (formAttributes as DateTimeFormAttribute).onChanged,
          dateTimeInputType: (formAttributes as DateTimeFormAttribute).type,
          readOnly: (formAttributes as DateTimeFormAttribute).readOnly,
          maxDate: (formAttributes as DateTimeFormAttribute).maxDate,
          minDate: (formAttributes as DateTimeFormAttribute).minDate,
          currentDate: (formAttributes as DateTimeFormAttribute).currentDate,
        ),
      SingleSelectFormAttribute() => MultiSelectFormField(
          label: (formAttributes as SingleSelectFormAttribute).label,
          hintText: (formAttributes as SingleSelectFormAttribute).hintText,
          fieldName: (formAttributes as SingleSelectFormAttribute).fieldName,
          initialValue: [
            if ((formAttributes as SingleSelectFormAttribute).initialValue !=
                null)
              (formAttributes as SingleSelectFormAttribute).initialValue
          ],
          onChanged: (formAttributes as SingleSelectFormAttribute).onChanged,
          options: (formAttributes as SingleSelectFormAttribute).options,
          isRequired: (formAttributes as SingleSelectFormAttribute).isRequired,
          allowMultiSelect: false,
          readOnly: (formAttributes as SingleSelectFormAttribute).readOnly,
          controller: (formAttributes as SingleSelectFormAttribute).controller,
          disabled: (formAttributes as SingleSelectFormAttribute).disable,
        ),
      MultiSelectFormAttributes() => MultiSelectFormField(
          label: (formAttributes as MultiSelectFormAttributes).label,
          hintText: (formAttributes as MultiSelectFormAttributes).hintText,
          fieldName: (formAttributes as MultiSelectFormAttributes).fieldName,
          initialValue:
              (formAttributes as MultiSelectFormAttributes).initialValue,
          onChanged: (formAttributes as MultiSelectFormAttributes).onChanged,
          options: (formAttributes as MultiSelectFormAttributes).options,
          isRequired: (formAttributes as MultiSelectFormAttributes).isRequired,
          controller: (formAttributes as MultiSelectFormAttributes).controller,
        ),
      ImagePickerFormAttributes(
        isRequired: bool isRequired,
        imageUrl: String imageUrl,
        onDeleted: VoidCallback onDeleted,
      ) =>
        FormImagePicker(
          fieldName: formAttributes.fieldName,
          imageUrl: imageUrl,
          label: formAttributes.label,
          initialFile: formAttributes.initialValue,
          onChanged: formAttributes.onChanged,
          isRequired: isRequired,
          onDeleted: onDeleted,
        ),
      CheckboxFormAttributes() => CheckBoxFormField(
          fieldName: formAttributes.fieldName,
          label: formAttributes.label,
          initialValue: formAttributes.initialValue,
          controller: (formAttributes as CheckboxFormAttributes).controller,
          onChanged: (formAttributes as CheckboxFormAttributes).onChanged,
          showBorder: (formAttributes as CheckboxFormAttributes).showBorder,
        ),
      RadioFormAttributes() => Container(),
      SwitchFormAttributes() => Container(),
    };
  }
}
