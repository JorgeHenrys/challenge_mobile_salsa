import '../../domain/repositories/settings_repository.dart';
import '../datasources/local/local_storage_service.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final LocalStorageService localStorageService;

  SettingsRepositoryImpl({required this.localStorageService});

  @override
  Future<bool> isDarkMode() async {
    return localStorageService.getBool('isDarkMode') ?? false;
  }

  @override
  Future<void> setDarkMode(bool isDark) async {
    await localStorageService.setBool('isDarkMode', isDark);
  }

  @override
  Future<List<String>> getFavorites() async {
    return localStorageService.getList('favorites');
  }

  @override
  Future<void> addFavorite(String itemId) async {
    await localStorageService.addToList('favorites', itemId);
  }

  @override
  Future<void> removeFavorite(String itemId) async {
    await localStorageService.removeFromList('favorites', itemId);
  }

  @override
  Future<bool> isFavorite(String itemId) async {
    return localStorageService.listContains('favorites', itemId);
  }
}
