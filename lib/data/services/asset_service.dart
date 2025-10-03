import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import '../models/user_model.dart';
import '../models/item_model.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/entities/item_entity.dart';

class AssetService {
  static Future<List<UserModel>> loadUserModels() async {
    try {
      final String data = await rootBundle.loadString(
        'assets/mocks/users/users_login_mock.json',
      );
      final List<dynamic> jsonList = json.decode(data) as List<dynamic>;

      return jsonList.map((userJson) => UserModel.fromJson(userJson)).toList();
    } catch (e) {
      debugPrint('Erro ao carregar users: $e');
      return [];
    }
  }

  static Future<List<ItemModel>> loadItemModels() async {
    try {
      final String data = await rootBundle.loadString(
        'assets/mocks/items/all_items_mock.json',
      );
      final List<dynamic> jsonList = json.decode(data) as List<dynamic>;

      return jsonList.map((itemJson) => ItemModel.fromJson(itemJson)).toList();
    } catch (e) {
      debugPrint('Erro ao carregar items: $e');
      return [];
    }
  }

  static Future<List<UserEntity>> loadUsers() async {
    final models = await loadUserModels();
    return models.map((model) => model.toEntity()).toList();
  }

  static Future<List<ItemEntity>> loadItems() async {
    final models = await loadItemModels();
    return models.map((model) => model.toEntity()).toList();
  }

  static Future<UserEntity?> authenticateUser(
    String email,
    String password,
  ) async {
    final models = await loadUserModels();
    try {
      final userModel = models.firstWhere(
        (user) => user.email == email && user.password == password,
      );
      return userModel.toEntity();
    } catch (e) {
      return null;
    }
  }

  static Future<List<UserModel>> getAvailableUserModels() async {
    return await loadUserModels();
  }

  static Future<List<ItemModel>> getAvailableItemModels() async {
    return await loadItemModels();
  }
}
