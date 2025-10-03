import 'dart:convert';

import '../../domain/repositories/user_repository.dart';
import '../datasources/local/local_storage_service.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final LocalStorageService localStorageService;

  UserRepositoryImpl({required this.localStorageService});

  @override
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    final user = UserModel(id: '1', name: 'John Doe', email: email);

    await saveUser(user);
    await localStorageService.setBool('isLoggedIn', true);

    return true;
  }

  @override
  Future<void> logout() async {
    await localStorageService.setBool('isLoggedIn', false);
  }

  @override
  Future<bool> isLoggedIn() async {
    return localStorageService.getBool('isLoggedIn') ?? false;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final userJson = localStorageService.getString('currentUser');
    if (userJson != null) {
      return UserModel.fromJson(json.decode(userJson));
    }
    return null;
  }

  @override
  Future<void> saveUser(UserModel user) async {
    await localStorageService.setString(
      'currentUser',
      json.encode(user.toJson()),
    );
  }
}
