import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_project_name/core/error/exeptions.dart';
import 'package:my_project_name/core/error/failure.dart';
import 'package:my_project_name/features/authentication/data/model/get_me_response_model.dart';
import 'package:my_project_name/features/authentication/data/model/login_response_model.dart';
import 'package:my_project_name/features/authentication/data/model/signup_response_model.dart';
import 'package:my_project_name/features/authentication/data/model/token_taker_model.dart';
import 'package:my_project_name/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:my_project_name/features/authentication/domain/entity/getme_entity.dart';
import 'package:my_project_name/features/authentication/domain/entity/login_entity.dart';
import 'package:my_project_name/features/authentication/domain/entity/signup_entity.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late MockAuthLocalDataSource mockAuthLocalDataSource;
  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    mockAuthLocalDataSource = MockAuthLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = AuthRepositoryImpl(
      authRemoteDataSource: mockAuthRemoteDataSource,
      networkInfo: mockNetworkInfo,
      authLocalDataSource: mockAuthLocalDataSource,
    );
  });
  const testSignUpModel = SignupResponseModel(
      name: 'john', email: 'user@gmail.com', password: 'abcd1234');
  const testSignUpEntity =
      SignUpEntity(name: 'john', email: 'user@gmail.com', password: 'abcd1234');
  const testLoginModel =
      LoginResponseModel(email: 'user@gmail.com', password: 'abcd1234');
  const testLoginEntity =
      LoginEntity(email: 'user@gmail.com', password: 'abcd1234');
  const testTokenModel = TokenTakerModel(
    token: 'abcd',
  );
  String testToken = 'abc';
  const testGetMeModel = GetMeResponseModel(name: 'john');
  const testGetMeEntity = GetMeEntity(name: 'john');

  void deviceOnline() {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });
  }

  void deviceOffline() {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });
  }

  group('signup ', () {
    group('when the device is online', () {
      deviceOnline();
      test(
          'should return null when a call to the remote data source is successful',
          () async {
        //arrange
        when(mockAuthRemoteDataSource.signUp(testSignUpModel))
            .thenAnswer((_) async => const Right(null));

        //act
        final result = await repository.signUp(testSignUpEntity);

        //assert
        expect(result, equals(const Right(null)));
      });
      test(
          'should return a server failure when a call to the remote data source is unsuccessful',
          () async {
        //arrange
        when(mockAuthRemoteDataSource.signUp(testSignUpModel))
            .thenThrow(ServerException());
        //act
        final result = await repository.signUp(testSignUpEntity);

        //assert
        expect(result, equals(Left(ServerFailure())));
      });
    });
    group('device is ofline', () {
      // This setUp applies only to the 'device is online' group
      deviceOffline();

      test('should return connection failure when the device has no internet',
          () async {
        //arrange
        when(mockAuthRemoteDataSource.signUp(testSignUpModel))
            .thenThrow(SocketException());
        //act
        final result = await repository.signUp(testSignUpEntity);

        //assert
        expect(result, equals(Left(ConnectionFailure())));
      });
    });
  });
  group('login ', () {
    group('when the device is online', () {
      deviceOnline();
      test(
          'should return tokentaker model when a call to the remote data source is successful',
          () async {
        //arrange
        when(mockAuthRemoteDataSource.login(testLoginModel))
            .thenAnswer((_) async => testTokenModel);

        //act
        final result = await repository.login(testLoginEntity);

        //assert
        expect(result, equals(const Right(null)));
      });
      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockAuthRemoteDataSource.login(testLoginModel))
              .thenAnswer((_) async => testTokenModel);
          when(mockAuthLocalDataSource.cacheToken(testTokenModel))
              .thenAnswer((_) async => const Right(null));
          // act

          await repository.login(testLoginEntity);
          // assert
          verify(mockAuthRemoteDataSource.login(testLoginModel));
          verify(mockAuthLocalDataSource.cacheToken(testTokenModel));
        },
      );
      test(
          'should return a server failure when a call to the remote data source is unsuccessful',
          () async {
        //arrange
        when(mockAuthRemoteDataSource.login(testLoginModel))
            .thenThrow(ServerException());
        //act
        final result = await repository.login(testLoginEntity);

        //assert
        expect(result, equals(Left(ServerFailure())));
      });
    });
    group('device is offline', () {
      // This setUp applies only to the 'device is online' group
      deviceOffline();

      test('should return connection failure when the device has no internet',
          () async {
        //arrange
        when(mockAuthRemoteDataSource.login(testLoginModel))
            .thenThrow(SocketException());
        //act
        final result = await repository.login(testLoginEntity);

        //assert
        expect(result, equals(Left(ConnectionFailure())));
      });
    });
  });
  group('getMe ', () {
    group('when the device is online', () {
      deviceOnline();
      test(
          'should return GetMeModel model when a call to the remote data source is successful',
          () async {
        //arrange

        when(mockAuthLocalDataSource.getToken())
            .thenAnswer((_) async => testToken);
        when(mockAuthRemoteDataSource.getMe(testToken))
            .thenAnswer((_) async => testGetMeModel);

        //act
        final result = await repository.getMe();

        //assert
        expect(result, equals(const Right(testGetMeEntity)));
      });
      test(
          'should return a server failure when a call to the remote data source is unsuccessful',
          () async {
        //arrange
        when(mockAuthLocalDataSource.getToken())
            .thenAnswer((_) async => testToken);
        when(mockAuthRemoteDataSource.getMe(testToken))
            .thenThrow(ServerException());
        //act
        final result = await repository.getMe();

        //assert
        expect(result, equals(Left(ServerFailure())));
      });
    });
    group('device is offline', () {
      // This setUp applies only to the 'device is offline' group
      deviceOffline();

      test('should return connection failure when the device has no internet',
          () async {
        //arrange
        when(mockAuthRemoteDataSource.getMe(testToken))
            .thenThrow(SocketException());
        //act
        final result = await repository.getMe();

        //assert
        expect(result, equals(Left(ConnectionFailure())));
      });
    });
  });
  group('logOut ', () {
    test(
        'should return null when a call to the local data source is successful',
        () async {
      //arrange
      when(mockAuthLocalDataSource.deleteToken())
          .thenAnswer((_) async => (null));

      //act
      final result = await repository.logout();

      //assert
      expect(result, equals(const Right(null)));
    });
    test(
        'should return a cache failure when a call to the local data source is unsuccessful',
        () async {
      //arrange
      when(mockAuthLocalDataSource.deleteToken()).thenThrow(CacheException());
      //act
      final result = await repository.logout();

      //assert
      expect(result, equals(Left(CacheFailure())));
    });
  });
}
