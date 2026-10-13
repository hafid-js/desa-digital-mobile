import 'package:flutter/material.dart';
import 'package:desa_digital/core/constants/app_colors.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headlineSmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AppColors.dark,
    ),

    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.dark,
    ),

    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.dark,
    ),

    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.dark,
    ),

    bodyLarge: TextStyle(fontSize: 16, color: AppColors.dark),

    bodyMedium: TextStyle(fontSize: 14, color: AppColors.textPrimaryLight),

    labelSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimaryLight,
    ),

    labelMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimaryLight,
    ),

    labelLarge: TextStyle(fontSize: 16, color: AppColors.textPrimaryLight),
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimaryDark,
    ),

    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryDark,
    ),

    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryDark,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryDark,
    ),

    bodyLarge: TextStyle(fontSize: 16, color: AppColors.textPrimaryDark),

    bodyMedium: TextStyle(fontSize: 14, color: AppColors.textSecondaryDark),

    labelSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,

      color: AppColors.textSecondaryDark,
    ),

    labelMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondaryDark,
    ),

    labelLarge: TextStyle(fontSize: 16, color: AppColors.textSecondaryDark),
  );
}
