import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../data/models/item_model.dart';
import '../../data/services/asset_service.dart';
import '../../domain/entities/item_entity.dart';
import '../../domain/repositories/settings_repository.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreImp with _$HomeStore;

abstract class HomeStoreImp with Store {
  final SettingsRepository settingsRepository;

  HomeStoreImp(this.settingsRepository);

  @observable
  ObservableList<ItemEntity> items = ObservableList.of([]);

  @observable
  bool isLoading = false;

  @observable
  String filterCategory = 'Todos';

  @observable
  List<String> categories = ['Todos'];

  @action
  Future<void> loadItems() async {
    isLoading = true;
    try {
      final List<ItemModel> loadedModels =
          await AssetService.getAvailableItemModels();

      final uniqueCategories = loadedModels
          .map((item) => item.category)
          .toSet()
          .toList();
      categories = ['Todos', ...uniqueCategories];

      final favorites = await settingsRepository.getFavorites();

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
    final itemIndex = items.indexWhere((item) => item.id == itemId);
    if (itemIndex != -1) {
      final item = items[itemIndex];
      final newFavoriteStatus = !item.isFavorite;

      items[itemIndex] = item.copyWith(isFavorite: newFavoriteStatus);

      if (newFavoriteStatus) {
        await settingsRepository.addFavorite(itemId);
      } else {
        await settingsRepository.removeFavorite(itemId);
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
