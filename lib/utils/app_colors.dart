import 'package:flutter/material.dart';

class AppColors {
  // Основні кольори проєкту
  static const primary = Color(0xFF0066FF);
  static const background = Colors.white;

  // Можливі кольори для аватарок
  static const List<Color> avatarPalette = [
    Color(0xFFEF5350), // red
    Color(0xFFAB47BC), // purple
    Color(0xFF42A5F5), // blue
    Color(0xFF26A69A), // teal
    Color(0xFFFFCA28), // amber
    Color(0xFF8D6E63), // brown
  ];

  /// Генерує стабільний колір на основі uid
  static Color generateStableColor(String uid) {
    final index = uid.hashCode % avatarPalette.length;
    return avatarPalette[index];
  }

  /// Перевірка чи колір занадто світлий
  static bool isColorTooLight(Color color) {
    final brightness =
        (color.red * 0.299 + color.green * 0.587 + color.blue * 0.114) / 255;
    return brightness > 0.8;
  }

  /// Робить колір темнішим, якщо він надто світлий
  static Color adjustColorForText(Color color) {
    if (!isColorTooLight(color)) return color;

    return Color.fromARGB(
      color.alpha,
      (color.red * 0.7).toInt(),
      (color.green * 0.7).toInt(),
      (color.blue * 0.7).toInt(),
    );
  }
}
