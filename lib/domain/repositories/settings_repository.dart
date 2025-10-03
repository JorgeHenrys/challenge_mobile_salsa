abstract class SettingsRepository {
  Future<bool> isDarkMode();
  Future<void> setDarkMode(bool isDark);
  Future<List<String>> getFavorites();
  Future<void> addFavorite(String itemId);
  Future<void> removeFavorite(String itemId);
  Future<bool> isFavorite(String itemId);
}
