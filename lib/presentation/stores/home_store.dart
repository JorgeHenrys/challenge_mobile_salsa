import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../data/models/item_model.dart';
import '../../data/services/asset_service.dart';
import '../../domain/entities/item_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/repositories/user_repository.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreImp with _$HomeStore;

abstract class HomeStoreImp with Store {
  final SettingsRepository settingsRepository;
  final UserRepository userRepository;

  HomeStoreImp(this.settingsRepository, this.userRepository);

  @observable
  ObservableList<ItemEntity> items = ObservableList.of([]);

  @observable
  bool isLoading = false;

  @observable
  String filterCategory = 'Todos';

  @observable
  List<String> categories = ['Todos'];

  @observable
  UserEntity? currentUser;

  @action
  Future<void> loadCurrentUser() async {
    currentUser = await userRepository.getCurrentUser();
  }

  @action
  Future<void> loadItems() async {
    isLoading = true;
    try {
      await loadCurrentUser();
      if (currentUser == null) return;

      final List<ItemModel> loadedModels =
          await AssetService.getAvailableItemModels();

      final uniqueCategories = loadedModels
          .map((item) => item.category)
          .toSet()
          .toList();
      categories = ['Todos', ...uniqueCategories];

      final favorites = await settingsRepository.getFavorites(currentUser!.id);

      final List<ItemEntity> loadedItems = loadedModels.map((model) {
        return model.toEntity().copyWith(
          isFavorite: favorites.contains(model.id),
        );
      }).toList();

      items.clear();
      items.addAll(loadedItems);
    } catch (e) {
      debugPrint('Erro ao carregar items: $e');
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> toggleFavorite(String itemId) async {
    if (currentUser == null) return;

    final itemIndex = items.indexWhere((item) => item.id == itemId);
    if (itemIndex != -1) {
      final item = items[itemIndex];
      final newFavoriteStatus = !item.isFavorite;

      items[itemIndex] = item.copyWith(isFavorite: newFavoriteStatus);

      if (newFavoriteStatus) {
        await settingsRepository.addFavorite(currentUser!.id, itemId);
      } else {
        await settingsRepository.removeFavorite(currentUser!.id, itemId);
      }
    }
  }

  @action
  void setFilterCategory(String category) {
    filterCategory = category;
  }

  @computed
  List<ItemEntity> get filteredItems {
    if (filterCategory == 'Todos') {
      return items.toList();
    }
    return items.where((item) => item.category == filterCategory).toList();
  }

  @computed
  List<ItemEntity> get favoriteItems {
    return items.where((item) => item.isFavorite).toList();
  }
}
