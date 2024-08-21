import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_project_name/core/usecase/usecase.dart';
import 'package:my_project_name/features/authentication/domain/usecases/logout.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late LogoutUseCase logoutUseCase;
  late MockAuthRepository mockauthRepository;
  setUp(() {
    mockauthRepository = MockAuthRepository();
    logoutUseCase = LogoutUseCase(mockauthRepository);
  });
  test('should pass to repository to logout', () async {
    when(mockauthRepository.logout())
        .thenAnswer((_) async => const Right(null));
    final result = await logoutUseCase(NoParams());
    expect(result, const Right(null));
  });
}
