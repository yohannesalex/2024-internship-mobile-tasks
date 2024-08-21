import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_project_name/features/authentication/domain/entity/login_entity.dart';
import 'package:my_project_name/features/authentication/domain/usecases/login.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late LoginUseCase loginUsecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginUsecase = LoginUseCase(mockAuthRepository);
  });

  const testUserdetail = LoginEntity(
    email: 'abc@gmail.com',
    password: 'abcd1234',
  );
  test('should sign up the user in the repository', () async {
    // Arrange
    when(mockAuthRepository.login(testUserdetail))
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await loginUsecase(const LoginParams(user: testUserdetail));

    // Assert
    expect(result, const Right(null));
    verify(mockAuthRepository.login(testUserdetail));
  });
}
