import 'package:flutter/material.dart' show ThemeMode;

class AppSettings {
  const AppSettings({
    required this.name,
    required this.email,
    required this.location,
    required this.language,
    required this.syncEnabled,
    required this.lastSync,
    required this.version,
    this.phone,
    this.themeMode = ThemeMode.system,
  });

  final String name;
  final String email;
  final String? phone;
  final String location;
  final String language;
  final bool syncEnabled;
  final String lastSync;
  final String version;
  final ThemeMode themeMode;

  AppSettings copyWith({bool? syncEnabled, String? language, ThemeMode? themeMode}) =>
      AppSettings(
        name: name,
        email: email,
        phone: phone,
        location: location,
        language: language ?? this.language,
        syncEnabled: syncEnabled ?? this.syncEnabled,
        lastSync: lastSync,
        version: version,
        themeMode: themeMode ?? this.themeMode,
      );
}

/// Fake for the UI phase. Version will come from package_info later.
// ponytail: theme choice isn't persisted yet; saved with the rest of the
// settings in the logic phase.
class SettingsRepository {
  AppSettings load() => const AppSettings(
        name: 'طارق محمد',
        email: 'tarek@example.com',
        location: 'القاهرة، مصر',
        language: 'العربية',
        syncEnabled: true,
        lastSync: 'من دقيقتين',
        version: '1.0.0 (1)',
      );
}
