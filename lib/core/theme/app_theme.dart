import 'package:desa_digital/core/constants/app_colors.dart';
import 'package:desa_digital/core/theme/app_shadows.dart';
import 'package:desa_digital/core/theme/app_text_theme.dart';
import 'package:desa_digital/core/utils/color_utils.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const List<BoxShadow> _smallShadows = [
    BoxShadow(color: Color(0x0D000000), blurRadius: 8, offset: Offset(0, 2)),
  ];

  static const List<BoxShadow> _mediumShadows = [
    BoxShadow(color: Color(0x1A000000), blurRadius: 16, offset: Offset(0, 6)),
  ];

  static const List<BoxShadow> _largeShadows = [
    BoxShadow(color: Color(0x26000000), blurRadius: 24, offset: Offset(0, 10)),
  ];

  static const AppShadow _shadowExtension = AppShadow(
    small: _smallShadows,
    medium: _mediumShadows,
    large: _largeShadows,
  );

  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      disabledColor: AppColors.lightDisableColor,

      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.lightSurface,
      ),

      iconTheme: const IconThemeData(color: AppColors.textPrimaryLight),

      textTheme: AppTextTheme.lightTextTheme,

      scaffoldBackgroundColor: AppColors.light,
      cardColor: AppColors.lightCard,
      extensions: const [_shadowExtension],
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      disabledColor: AppColors.darkDisableColor,

      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.darkSurface,
      ),

      iconTheme: const IconThemeData(color: AppColors.textPrimaryDark),

      textTheme: AppTextTheme.darkTextTheme,

      scaffoldBackgroundColor: HexColor.fromHex('#132D3B').withAlpha(120),
      cardColor: AppColors.darkCard,
      extensions: const [_shadowExtension],
    );
  }
}
