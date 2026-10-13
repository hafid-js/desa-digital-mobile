import 'package:desa_digital/app/routes/app_pages.dart';
import 'package:desa_digital/app/routes/app_routes.dart';
import 'package:desa_digital/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DesaDigitalApp extends StatelessWidget {
  const DesaDigitalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Desa Digital',

      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: ThemeMode.light,

      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.noScaling),
          child: child!,
        );
      },

      initialRoute: Routes.mainShell,
      getPages: AppPages.pages,
    );
  }
}
