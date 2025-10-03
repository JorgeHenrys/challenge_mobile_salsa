import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final String password;

  UserModel({
    required super.id,
    required super.name,
    required super.email,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'password': password};
  }

  UserEntity toEntity() {
    return UserEntity(id: id, name: name, email: email);
  }

  factory UserModel.fromEntity(UserEntity entity, {String password = ''}) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      password: password,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ email.hashCode ^ password.hashCode;
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email)';
  }
}
