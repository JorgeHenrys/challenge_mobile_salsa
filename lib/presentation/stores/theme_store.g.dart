// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ThemeStore on ThemeStoreImp, Store {
  late final _$isDarkModeAtom = Atom(
    name: 'ThemeStoreImp.isDarkMode',
    context: context,
  );

  @override
  bool get isDarkMode {
    _$isDarkModeAtom.reportRead();
    return super.isDarkMode;
  }

  @override
  set isDarkMode(bool value) {
    _$isDarkModeAtom.reportWrite(value, super.isDarkMode, () {
      super.isDarkMode = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: 'ThemeStoreImp.isLoading',
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

  late final _$loadThemeAsyncAction = AsyncAction(
    'ThemeStoreImp.loadTheme',
    context: context,
  );

  @override
  Future<void> loadTheme() {
    return _$loadThemeAsyncAction.run(() => super.loadTheme());
  }

  late final _$toggleThemeAsyncAction = AsyncAction(
    'ThemeStoreImp.toggleTheme',
    context: context,
  );

  @override
  Future<void> toggleTheme() {
    return _$toggleThemeAsyncAction.run(() => super.toggleTheme());
  }

  late final _$setDarkModeAsyncAction = AsyncAction(
    'ThemeStoreImp.setDarkMode',
    context: context,
  );

  @override
  Future<void> setDarkMode(bool value) {
    return _$setDarkModeAsyncAction.run(() => super.setDarkMode(value));
  }

  @override
  String toString() {
    return '''
isDarkMode: ${isDarkMode},
isLoading: ${isLoading}
    ''';
  }
}
