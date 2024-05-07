part of 'common_form_attributes.dart';

class MultiSelectFormAttributes<Type> extends CommonFormAttributes<List<Type>> {
  final String hintText;
  final List<FormOptions<Type>> options;
  final bool isRequired;
  final MultiSelectFormController? controller;

  MultiSelectFormAttributes({
    required super.initialValue,
    required super.label,
    super.onChanged,
    required super.fieldName,
    this.hintText = "",
    this.isRequired = false,
    required this.options,
    this.controller,
  });
}
