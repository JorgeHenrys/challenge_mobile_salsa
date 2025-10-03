import '../../data/models/user_model.dart';

abstract class UserRepository {
  Future<bool> login(String email, String password);
  Future<void> logout();
  Future<bool> isLoggedIn();
  Future<UserModel?> getCurrentUser();
  Future<void> saveUser(UserModel user);
}
