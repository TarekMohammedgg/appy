import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/settings_repository.dart';

class SettingsCubit extends Cubit<AppSettings> {
  SettingsCubit(SettingsRepository repository) : super(repository.load());

  void setSync(bool on) => emit(state.copyWith(syncEnabled: on));

  void setLanguage(String language) => emit(state.copyWith(language: language));
}
