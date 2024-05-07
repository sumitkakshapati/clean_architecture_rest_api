part of 'common_form_attributes.dart';

class SingleSelectFormAttribute<Type> extends CommonFormAttributes<Type?> {
  final String hintText;
  final List<FormOptions<Type>> options;
  final bool isRequired;
  final MultiSelectFormController? controller;
  final bool readOnly;
  final bool disable;

  SingleSelectFormAttribute({
    super.initialValue,
    required super.label,
    super.onChanged,
    required super.fieldName,
    this.hintText = "",
    this.isRequired = false,
    required this.options,
    this.controller,
    this.readOnly = false,
    this.disable = false,
  });
}
