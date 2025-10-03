class UserEntity {
  final String id;
  final String name;
  final String email;

  UserEntity({required this.id, required this.name, required this.email});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserEntity &&
        other.id == id &&
        other.name == name &&
        other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ email.hashCode;

  @override
  String toString() {
    return 'UserEntity(id: $id, name: $name, email: $email)';
  }
}
