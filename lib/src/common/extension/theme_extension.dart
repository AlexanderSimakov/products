import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
