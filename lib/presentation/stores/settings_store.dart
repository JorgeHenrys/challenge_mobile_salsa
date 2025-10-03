import 'package:mobx/mobx.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/repositories/user_repository.dart';

part 'settings_store.g.dart';

class SettingsStore = SettingsStoreImp with _$SettingsStore;

abstract class SettingsStoreImp with Store {
  final SettingsRepository settingsRepository;
  final UserRepository userRepository;

  SettingsStoreImp(this.settingsRepository, this.userRepository);

  @observable
  UserEntity? currentUser;

  @observable
  bool isLoading = false;

  @action
  Future<void> loadSettings() async {
    isLoading = true;
    currentUser = await userRepository.getCurrentUser();
    isLoading = false;
  }

  @action
  Future<void> logout() async {
    await userRepository.logout();
  }
}
