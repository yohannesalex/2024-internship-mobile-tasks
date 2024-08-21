import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/user.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase implements UseCase<void, LoginParams> {
  final AuthRepository authRepository;
  LoginUseCase(this.authRepository);

  @override
  Future<Either<Failure, void>> call(LoginParams loginParams) async {
    return await authRepository.login(loginParams.user);
  }
}

class LoginParams extends Equatable {
  final UserEntity user;

  const LoginParams({required this.user});
  @override
  List<Object?> get props => [user];
}