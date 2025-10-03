import 'package:mobx/mobx.dart';

import '../../domain/repositories/settings_repository.dart';

part 'theme_store.g.dart';

class ThemeStore = ThemeStoreImp with _$ThemeStore;

abstract class ThemeStoreImp with Store {
  final SettingsRepository settingsRepository;

  ThemeStoreImp(this.settingsRepository);

  @observable
  bool isDarkMode = false;

  @observable
  bool isLoading = false;

  @action
  Future<void> loadTheme() async {
    isLoading = true;
    isDarkMode = await settingsRepository.isDarkMode();
    isLoading = false;
  }

  @action
  Future<void> toggleTheme() async {
    isDarkMode = !isDarkMode;
    await settingsRepository.setDarkMode(isDarkMode);
  }

  @action
  Future<void> setDarkMode(bool value) async {
    isDarkMode = value;
    await settingsRepository.setDarkMode(value);
  }
}
