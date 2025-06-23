import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF6200EE);
  static const Color primaryVariant = Color(0xFF3700B3);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color secondaryVariant = Color(0xFF018786);
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFB00020);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFF000000);
  static const Color onBackground = Color(0xFF000000);
  static const Color onSurface = Color(0xFF000000);
  static const Color onError = Color(0xFFFFFFFF);
}

class AppTextStyles {
  static const TextStyle noteTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static const TextStyle noteContent = TextStyle(
    fontSize: 14,
    color: Colors.black54,
  );

  static const TextStyle noteDate = TextStyle(fontSize: 12, color: Colors.grey);
}

class AppSizes {
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 12.0;

  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;
}

class AppStrings {
  static const String appName = 'Заметки';
  static const String emptyNotes = 'Нет заметок';
  static const String loadingError = 'Ошибка загрузки';
  static const String newNote = 'Новая заметка';
  static const String editNote = 'Редактировать';
  static const String searchHint = 'Поиск заметок...';
  static const String deleteConfirm = 'Удалить заметку?';
  static const String delete = 'Удалить';
  static const String cancel = 'Отмена';
}

class AppAssets {
  static const String logo = 'assets/images/logo.png';
  static const String emptyState = 'assets/images/empty.png';
}
