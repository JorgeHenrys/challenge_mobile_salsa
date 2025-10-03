abstract class SettingsRepository {
  Future<bool> isDarkMode();
  Future<void> setDarkMode(bool isDark);
  Future<List<String>> getFavorites(String userId);
  Future<void> addFavorite(String userId, String itemId);
  Future<void> removeFavorite(String userId, String itemId);
  Future<bool> isFavorite(String userId, String itemId);
}
