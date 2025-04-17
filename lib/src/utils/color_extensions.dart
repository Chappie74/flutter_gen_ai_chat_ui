import 'package:flutter/material.dart';

/// Extensions on [Color] class to provide utility methods for color manipulation
extension ColorExtensions on Color {
  /// Creates a new color with modified values
  ///
  /// This method allows you to modify specific channels of a color:
  /// - [red] - The red channel value (0-255)
  /// - [green] - The green channel value (0-255)
  /// - [blue] - The blue channel value (0-255)
  /// - [alpha] - The alpha/opacity channel value (0-1.0 or 0-255)
  ///
  /// If a parameter is not specified, the original value is maintained.
  /// Alpha can be specified as either 0-1.0 or 0-255.
  Color withValues({
    int? red,
    int? green,
    int? blue,
    dynamic alpha,
  }) {
    // Handle alpha which could be specified as either 0-1.0 or 0-255
    int? alphaValue;
    if (alpha != null) {
      if (alpha is double && alpha >= 0 && alpha <= 1.0) {
        alphaValue = (alpha * 255).round();
      } else if (alpha is int && alpha >= 0 && alpha <= 255) {
        alphaValue = alpha;
      } else {
        throw ArgumentError(
            'Alpha must be a double between 0.0 and 1.0, or an int between 0 and 255');
      }
    }

    return Color.fromARGB(
      alphaValue ?? a.toInt(),
      red ?? r.toInt(),
      green ?? g.toInt(),
      blue ?? b.toInt(),
    );
  }

  /// Sets the opacity without using the deprecated withOpacity.
  Color withOpacityCompat(double opacity) {
    final clamped = opacity.clamp(0.0, 1.0);
    return withValues(alpha: clamped);
  }
}
