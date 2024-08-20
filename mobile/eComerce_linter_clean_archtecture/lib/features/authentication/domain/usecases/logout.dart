import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class LogoutUseCase implements UseCase<void, LogoutParams> {
  final AuthRepository authRepository;
  LogoutUseCase(this.authRepository);

  @override
  Future<Either<Failure, void>> call(LogoutParams logoutParams) async {
    return await authRepository.logout(logoutParams.userId);
  }
}

class LogoutParams extends Equatable {
  final String userId;

  const LogoutParams({required this.userId});
  @override
  List<Object?> get props => [userId];
}
