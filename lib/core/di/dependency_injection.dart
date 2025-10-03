import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/datasources/local/local_storage_service.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../navigation/app_router.dart';

final GetIt locator = GetIt.instance;

class DependencyInjection {
  static Future<void> init() async {
    // External dependencies
    final sharedPreferences = await SharedPreferences.getInstance();
    locator.registerSingleton<SharedPreferences>(sharedPreferences);

    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);

    final localStorageService = LocalStorageService();
    await localStorageService.init();
    locator.registerSingleton<LocalStorageService>(localStorageService);

    // Repositories
    locator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(localStorageService: locator()),
    );

    locator.registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(localStorageService: locator()),
    );

    // Router
    locator.registerLazySingleton<AppRouter>(() => AppRouter());
  }
}
