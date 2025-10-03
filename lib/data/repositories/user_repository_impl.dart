import 'dart:convert';
import 'package:flutter/material.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/local/local_storage_service.dart';
import '../services/asset_service.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final LocalStorageService localStorageService;

  UserRepositoryImpl({required this.localStorageService});

  @override
  bool get isLoggedInSync {
    return localStorageService.getBool('isLoggedIn') ?? false;
  }

  @override
  Future<bool> login(String email, String password) async {
    try {
      final userEntity = await AssetService.authenticateUser(email, password);

      if (userEntity != null) {
        await saveUser(userEntity);
        await localStorageService.setBool('isLoggedIn', true);
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Login failed: $e');
      return false;
    }
  }

  @override
  Future<void> logout() async {
    await localStorageService.setBool('isLoggedIn', false);
    await localStorageService.setString('currentUser', '');
  }

  @override
  Future<bool> isLoggedIn() async {
    return localStorageService.getBool('isLoggedIn') ?? false;
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final userJson = localStorageService.getString('currentUser');
    if (userJson != null && userJson.isNotEmpty) {
      try {
        final Map<String, dynamic> jsonMap = json.decode(userJson);
        return UserEntity(
          id: jsonMap['id']?.toString() ?? '',
          name: jsonMap['name'] ?? '',
          email: jsonMap['email'] ?? '',
        );
      } catch (e) {
        debugPrint('Erro ao decodificar usuário: $e');
        return null;
      }
    }
    return null;
  }

  @override
  Future<void> saveUser(UserEntity user) async {
    final userMap = {'id': user.id, 'name': user.name, 'email': user.email};
    await localStorageService.setString('currentUser', json.encode(userMap));
  }

  @override
  Future<List<UserEntity>> getAvailableUsers() async {
    return await AssetService.loadUsers();
  }

  Future<List<UserModel>> getAvailableUserModels() async {
    return await AssetService.getAvailableUserModels();
  }
}
