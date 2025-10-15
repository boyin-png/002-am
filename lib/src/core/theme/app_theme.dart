import 'package:flutter/material.dart';

// Constantes para colores para fácil acceso y consistencia.
class AppColors {
  static const Color primary = Color(0XFF0E1534);
  static const Color onPrimary = Colors.white;
  static const Color error = Colors.redAccent;
}

// Constantes para espaciado para mantener la consistencia en los márgenes y paddings.
class AppSpacing {
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
}

// Clase principal del tema de la aplicación.
class AppTheme {
  // Método estático para obtener el ThemeData de la aplicación.
  static ThemeData getTheme() {
    return ThemeData(
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        error: AppColors.error,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        centerTitle: true,
      ),
      // Tema para todos los campos de texto de la aplicación.
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.small),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.small),
          borderSide: const BorderSide(color: AppColors.primary, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.small),
          borderSide: const BorderSide(color: AppColors.error, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.small),
          borderSide: const BorderSide(color: AppColors.error, width: 2.0),
        ),
      ),
      // Tema para los botones elevados.
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.large,
            vertical: AppSpacing.medium,
          ),
        ),
      ),
    );
  }
}
