import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../features/settings/data/settings_repository.dart';
import '../features/settings/presentation/view_model/settings_cubit.dart';
import 'router.dart';

class AppyApp extends StatelessWidget {
  const AppyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Settings sit above MaterialApp because the theme switch lives there.
    return BlocProvider(
      create: (_) => SettingsCubit(SettingsRepository()),
      child: BlocSelector<SettingsCubit, AppSettings, ThemeMode>(
        selector: (s) => s.themeMode,
        builder: (context, themeMode) => MaterialApp.router(
          title: 'appy',
          debugShowCheckedModeBanner: false,
          theme: buildTheme(AppColors.light, Brightness.light),
          darkTheme: buildTheme(AppColors.dark, Brightness.dark),
          themeMode: themeMode,
          // Arabic locale makes the whole app RTL.
          locale: const Locale('ar'),
          supportedLocales: const [Locale('ar'), Locale('en')],
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          scrollBehavior: const BouncyScrollBehavior(),
          routerConfig: appRouter,
        ),
      ),
    );
  }
}
