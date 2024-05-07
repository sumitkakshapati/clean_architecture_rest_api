import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/core/model/form_options.dart';

class MultiSelectFormController extends ValueNotifier<List<FormOptions>> {
  MultiSelectFormController({List<FormOptions> options = const []})
      : super(options);
}
