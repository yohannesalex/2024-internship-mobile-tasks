import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_project_name/features/authentication/domain/usecases/logout.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late LogoutUseCase logoutUseCase;
  late MockAuthRepository mockauthRepository;
  setUp(() {
    mockauthRepository = MockAuthRepository();
    logoutUseCase = LogoutUseCase(mockauthRepository);
  });
  const testUserId = '1';
  test('should pass to repository to logout', () async {
    when(mockauthRepository.logout(testUserId))
        .thenAnswer((_) async => const Right(null));
    final result = await logoutUseCase(const LogoutParams(userId: testUserId));
    expect(result, const Right(null));
  });
}
