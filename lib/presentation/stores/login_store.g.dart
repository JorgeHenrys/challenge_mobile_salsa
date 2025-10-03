// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginStore on LoginStoreImp, Store {
  Computed<bool>? _$canLoginComputed;

  @override
  bool get canLogin => (_$canLoginComputed ??= Computed<bool>(
    () => super.canLogin,
    name: 'LoginStoreImp.canLogin',
  )).value;

  late final _$emailAtom = Atom(name: 'LoginStoreImp.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$passwordAtom = Atom(
    name: 'LoginStoreImp.password',
    context: context,
  );

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: 'LoginStoreImp.isLoading',
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

  late final _$isLoadingUsersAtom = Atom(
    name: 'LoginStoreImp.isLoadingUsers',
    context: context,
  );

  @override
  bool get isLoadingUsers {
    _$isLoadingUsersAtom.reportRead();
    return super.isLoadingUsers;
  }

  @override
  set isLoadingUsers(bool value) {
    _$isLoadingUsersAtom.reportWrite(value, super.isLoadingUsers, () {
      super.isLoadingUsers = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: 'LoginStoreImp.errorMessage',
    context: context,
  );

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$availableUsersAtom = Atom(
    name: 'LoginStoreImp.availableUsers',
    context: context,
  );

  @override
  List<UserModel> get availableUsers {
    _$availableUsersAtom.reportRead();
    return super.availableUsers;
  }

  @override
  set availableUsers(List<UserModel> value) {
    _$availableUsersAtom.reportWrite(value, super.availableUsers, () {
      super.availableUsers = value;
    });
  }

  late final _$loadAvailableUsersAsyncAction = AsyncAction(
    'LoginStoreImp.loadAvailableUsers',
    context: context,
  );

  @override
  Future<void> loadAvailableUsers() {
    return _$loadAvailableUsersAsyncAction.run(
      () => super.loadAvailableUsers(),
    );
  }

  late final _$loginAsyncAction = AsyncAction(
    'LoginStoreImp.login',
    context: context,
  );

  @override
  Future<bool> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  late final _$LoginStoreImpActionController = ActionController(
    name: 'LoginStoreImp',
    context: context,
  );

  @override
  void setEmail(String value) {
    final _$actionInfo = _$LoginStoreImpActionController.startAction(
      name: 'LoginStoreImp.setEmail',
    );
    try {
      return super.setEmail(value);
    } finally {
      _$LoginStoreImpActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$LoginStoreImpActionController.startAction(
      name: 'LoginStoreImp.setPassword',
    );
    try {
      return super.setPassword(value);
    } finally {
      _$LoginStoreImpActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectUser(UserModel user) {
    final _$actionInfo = _$LoginStoreImpActionController.startAction(
      name: 'LoginStoreImp.selectUser',
    );
    try {
      return super.selectUser(user);
    } finally {
      _$LoginStoreImpActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
password: ${password},
isLoading: ${isLoading},
isLoadingUsers: ${isLoadingUsers},
errorMessage: ${errorMessage},
availableUsers: ${availableUsers},
canLogin: ${canLogin}
    ''';
  }
}
