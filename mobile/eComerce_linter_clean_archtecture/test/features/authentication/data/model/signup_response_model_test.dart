import 'package:flutter_test/flutter_test.dart';
import 'package:my_project_name/features/authentication/data/model/signup_response_model.dart';
import 'package:my_project_name/features/authentication/domain/entity/signup_entity.dart';

void main() {
  const testSignupModel = SignupResponseModel(
    name: 'john',
    email: 'user@gmail.com',
    password: 'abcd1234',
  );
  final expectedJson = {
    'name': 'john',
    'email': 'user@gmail.com',
    'password': 'abcd1234'
  };

  test('should return a json map containning proper data', () async {
    final result = testSignupModel.toJson();
    expect(result, expectedJson);
  });
  test('should be the subclass of user entity', () async {
    expect(testSignupModel, isA<SignUpEntity>());
  });
}
