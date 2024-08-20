import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> login(UserEntity user);
  Future<Either<Failure, void>> signUp(UserEntity user);
  Future<Either<Failure, void>> logout(String userId);
}
