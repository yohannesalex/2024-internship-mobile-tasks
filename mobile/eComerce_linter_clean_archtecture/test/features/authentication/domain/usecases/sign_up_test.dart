import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_project_name/features/authentication/domain/entity/signup_entity.dart';
import 'package:my_project_name/features/authentication/domain/usecases/sign_up.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late SignUpUseCase signUpUsecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signUpUsecase = SignUpUseCase(mockAuthRepository);
  });

  const testUserdetail =
      SignUpEntity(name: 'john', email: 'abc@gmail.com', password: 'abcd1234');

  test('should sign up the user in the repository', () async {
    // Arrange
    when(mockAuthRepository.signUp(any))
        .thenAnswer((_) async => const Right(null));

    // Act
    final result =
        await signUpUsecase(const SignUpParams(user: testUserdetail));

    // Assert
    expect(result, const Right(null));
    verify(mockAuthRepository.signUp(testUserdetail));
  });
}
