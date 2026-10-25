import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import 'router.dart';

class AppyApp extends StatelessWidget {
  const AppyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'appy',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(AppColors.light, Brightness.light),
      darkTheme: buildTheme(AppColors.dark, Brightness.dark),
      // Arabic locale makes the whole app RTL.
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar'), Locale('en')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      scrollBehavior: const BouncyScrollBehavior(),
      routerConfig: appRouter,
    );
  }
}
