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
  Future<List<String>> getFavorites(String userId) async {
    final key = 'favorites_$userId';
    return localStorageService.getList(key);
  }

  @override
  Future<void> addFavorite(String userId, String itemId) async {
    final key = 'favorites_$userId';
    await localStorageService.addToList(key, itemId);
  }

  @override
  Future<void> removeFavorite(String userId, String itemId) async {
    final key = 'favorites_$userId';
    await localStorageService.removeFromList(key, itemId);
  }

  @override
  Future<bool> isFavorite(String userId, String itemId) async {
    final key = 'favorites_$userId';
    return localStorageService.listContains(key, itemId);
  }
}
