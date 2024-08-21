import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_project_name/core/usecase/usecase.dart';
import 'package:my_project_name/features/authentication/domain/entity/getme_entity.dart';
import 'package:my_project_name/features/authentication/domain/usecases/getme.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetMeUseCase getMeUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    getMeUseCase = GetMeUseCase(mockAuthRepository);
  });
  const testGetMeEntity = GetMeEntity(name: 'john');
  test('should sign up the user in the repository', () async {
    // Arrange
    when(mockAuthRepository.getMe())
        .thenAnswer((_) async => const Right(testGetMeEntity));

    // Act
    final result = await getMeUseCase(NoParams());

    // Assert
    expect(result, const Right(testGetMeEntity));
    verify(mockAuthRepository.getMe());
  });
}
