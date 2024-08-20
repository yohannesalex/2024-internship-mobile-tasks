import 'package:flutter_test/flutter_test.dart';
import 'package:my_project_name/features/authentication/data/model/user_model.dart';
import 'package:my_project_name/features/authentication/domain/entity/user.dart';

void main() {
  const testUserModel = UserModel(
      id: '1', userName: 'john', email: 'abc@gmail.com', password: 'abcd1234');
  test('should be a subclass of a user entity', () async {
    expect(testUserModel, isA<UserEntity>());
  });
}
