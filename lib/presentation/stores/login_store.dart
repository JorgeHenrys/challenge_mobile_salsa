import 'package:mobx/mobx.dart';
import '../../data/models/user_model.dart';
import '../../data/services/asset_service.dart';
import '../../domain/repositories/user_repository.dart';

part 'login_store.g.dart';

class LoginStore = LoginStoreImp with _$LoginStore;

abstract class LoginStoreImp with Store {
  final UserRepository userRepository;

  LoginStoreImp(this.userRepository);

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  bool isLoading = false;

  @observable
  bool isLoadingUsers = false;

  @observable
  String errorMessage = '';

  @observable
  List<UserModel> availableUsers = [];

  @computed
  bool get canLogin => email.isNotEmpty && password.isNotEmpty && !isLoading;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

  @action
  Future<void> loadAvailableUsers() async {
    isLoadingUsers = true;
    try {
      availableUsers = await AssetService.getAvailableUserModels();
    } catch (e) {
      errorMessage = 'Erro ao carregar usuários: $e';
    } finally {
      isLoadingUsers = false;
    }
  }

  @action
  void selectUser(UserModel user) {
    email = user.email;
    password = user.password;
  }

  @action
  Future<bool> login() async {
    isLoading = true;
    errorMessage = '';

    try {
      final success = await userRepository.login(email, password);
      isLoading = false;

      if (!success) {
        errorMessage = 'Login falhou: Email ou senha incorretos';
      }

      return success;
    } catch (e) {
      isLoading = false;
      errorMessage = 'Login falhou: Email ou senha incorretos';
      return false;
    }
  }
}
