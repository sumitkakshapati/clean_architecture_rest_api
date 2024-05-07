part of 'common_form_attributes.dart';
class RadioFormAttributes<Type> extends CommonFormAttributes<Type> {
  final List<FormOptions<Type>> options;
  RadioFormAttributes({
    required super.initialValue,
    required super.label,
    super.onChanged,
    required this.options,
    required super.fieldName,
  });
}
