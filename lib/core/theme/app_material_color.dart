import 'package:flutter/material.dart';

class AppMaterialColor extends ColorSwatch<int> {
  const AppMaterialColor(super.primary, super.swatch);

  /// The second lightest shade.
  Color get shade100 => this[100]!;

  /// The fifth lightest shade.
  Color get shade400 => this[400]!;

  /// The default shade.
  Color get shade500 => this[500]!;
}
