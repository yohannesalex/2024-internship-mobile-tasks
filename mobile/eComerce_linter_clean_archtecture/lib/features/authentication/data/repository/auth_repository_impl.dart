import 'package:dartz/dartz.dart';

import '../../../../core/error/exeptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entity/getme_entity.dart';
import '../../domain/entity/login_entity.dart';
import '../../domain/entity/signup_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../model/login_response_model.dart';
import '../model/signup_response_model.dart';
import '../resource/auth_local_data_source.dart';
import '../resource/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo networkInfo;
  final AuthLocalDataSource authLocalDataSource;
  AuthRepositoryImpl(
      {required this.authRemoteDataSource,
      required this.networkInfo,
      required this.authLocalDataSource});

  @override
  Future<Either<Failure, void>> login(LoginEntity user) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await authRemoteDataSource.login(LoginResponseModel.toModel(user));

        await authLocalDataSource.cacheToken(result);
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      authLocalDataSource.deleteToken();
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signUp(SignUpEntity user) async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.signUp(SignupResponseModel.toModel(user));
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, GetMeEntity>> getMe() async {
    if (await networkInfo.isConnected) {
      final cachedToken = await authLocalDataSource.getToken();
      try {
        final result = await authRemoteDataSource.getMe(cachedToken);
        return Right(result.toEntity());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
