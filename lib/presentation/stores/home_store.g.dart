// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreImp, Store {
  Computed<List<ItemEntity>>? _$filteredItemsComputed;

  @override
  List<ItemEntity> get filteredItems =>
      (_$filteredItemsComputed ??= Computed<List<ItemEntity>>(
        () => super.filteredItems,
        name: 'HomeStoreImp.filteredItems',
      )).value;
  Computed<List<ItemEntity>>? _$favoriteItemsComputed;

  @override
  List<ItemEntity> get favoriteItems =>
      (_$favoriteItemsComputed ??= Computed<List<ItemEntity>>(
        () => super.favoriteItems,
        name: 'HomeStoreImp.favoriteItems',
      )).value;

  late final _$itemsAtom = Atom(name: 'HomeStoreImp.items', context: context);

  @override
  ObservableList<ItemEntity> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(ObservableList<ItemEntity> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: 'HomeStoreImp.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$filterCategoryAtom = Atom(
    name: 'HomeStoreImp.filterCategory',
    context: context,
  );

  @override
  String get filterCategory {
    _$filterCategoryAtom.reportRead();
    return super.filterCategory;
  }

  @override
  set filterCategory(String value) {
    _$filterCategoryAtom.reportWrite(value, super.filterCategory, () {
      super.filterCategory = value;
    });
  }

  late final _$categoriesAtom = Atom(
    name: 'HomeStoreImp.categories',
    context: context,
  );

  @override
  List<String> get categories {
    _$categoriesAtom.reportRead();
    return super.categories;
  }

  @override
  set categories(List<String> value) {
    _$categoriesAtom.reportWrite(value, super.categories, () {
      super.categories = value;
    });
  }

  late final _$currentUserAtom = Atom(
    name: 'HomeStoreImp.currentUser',
    context: context,
  );

  @override
  UserEntity? get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(UserEntity? value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$loadCurrentUserAsyncAction = AsyncAction(
    'HomeStoreImp.loadCurrentUser',
    context: context,
  );

  @override
  Future<void> loadCurrentUser() {
    return _$loadCurrentUserAsyncAction.run(() => super.loadCurrentUser());
  }

  late final _$loadItemsAsyncAction = AsyncAction(
    'HomeStoreImp.loadItems',
    context: context,
  );

  @override
  Future<void> loadItems() {
    return _$loadItemsAsyncAction.run(() => super.loadItems());
  }

  late final _$toggleFavoriteAsyncAction = AsyncAction(
    'HomeStoreImp.toggleFavorite',
    context: context,
  );

  @override
  Future<void> toggleFavorite(String itemId) {
    return _$toggleFavoriteAsyncAction.run(() => super.toggleFavorite(itemId));
  }

  late final _$HomeStoreImpActionController = ActionController(
    name: 'HomeStoreImp',
    context: context,
  );

  @override
  void setFilterCategory(String category) {
    final _$actionInfo = _$HomeStoreImpActionController.startAction(
      name: 'HomeStoreImp.setFilterCategory',
    );
    try {
      return super.setFilterCategory(category);
    } finally {
      _$HomeStoreImpActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
items: ${items},
isLoading: ${isLoading},
filterCategory: ${filterCategory},
categories: ${categories},
currentUser: ${currentUser},
filteredItems: ${filteredItems},
favoriteItems: ${favoriteItems}
    ''';
  }
}
