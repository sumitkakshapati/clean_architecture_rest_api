import 'package:flutter/material.dart';

class AppAccentColor extends ColorSwatch<int> {
  const AppAccentColor(super.primary, super.swatch);

  /// The second lightest shade.
  Color get shade100 => this[100]!;

  /// The default shade.
  Color get shade500 => this[500]!;
}
