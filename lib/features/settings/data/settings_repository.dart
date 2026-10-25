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
  });

  final String name;
  final String email;
  final String? phone;
  final String location;
  final String language;
  final bool syncEnabled;
  final String lastSync;
  final String version;

  AppSettings copyWith({bool? syncEnabled, String? language}) => AppSettings(
        name: name,
        email: email,
        phone: phone,
        location: location,
        language: language ?? this.language,
        syncEnabled: syncEnabled ?? this.syncEnabled,
        lastSync: lastSync,
        version: version,
      );
}

/// Fake for the UI phase. Version will come from package_info later.
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
