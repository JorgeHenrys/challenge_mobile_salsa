import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<bool> login(String email, String password);
  Future<void> logout();
  Future<bool> isLoggedIn();
  Future<UserEntity?> getCurrentUser();
  Future<void> saveUser(UserEntity user);
  Future<List<UserEntity>> getAvailableUsers();

  bool get isLoggedInSync;
}
