import '../../domain/entity/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.userName,
    required super.email,
    required super.password,
  });
}
