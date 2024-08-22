import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_project_name/core/error/failure.dart';
import 'package:my_project_name/core/usecase/usecase.dart';
import 'package:my_project_name/features/authentication/domain/entity/getme_entity.dart';
import 'package:my_project_name/features/authentication/domain/entity/login_entity.dart';
import 'package:my_project_name/features/authentication/domain/entity/signup_entity.dart';
import 'package:my_project_name/features/authentication/domain/usecases/login.dart';
import 'package:my_project_name/features/authentication/domain/usecases/sign_up.dart';
import 'package:my_project_name/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:my_project_name/features/authentication/presentation/bloc/auth_event.dart';
import 'package:my_project_name/features/authentication/presentation/bloc/auth_state.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late AuthBloc authBloc;
  late MockGetMeUseCase mockGetMeUseCase;
  late MockSignUpUseCase mockSignUpUseCase;
  late MockLoginUseCase mockLoginUseCase;
  late MockLogoutUseCase mockLogoutUseCase;
  setUp(() {
    mockGetMeUseCase = MockGetMeUseCase();
    mockSignUpUseCase = MockSignUpUseCase();
    mockLoginUseCase = MockLoginUseCase();
    mockLogoutUseCase = MockLogoutUseCase();
    authBloc = AuthBloc(
      mockGetMeUseCase,
      mockLoginUseCase,
      mockSignUpUseCase,
      mockLogoutUseCase,
    );
  });

  const testLoginEntity =
      LoginEntity(email: 'abcd@gmail.com', password: 'abcd1234');
  const testSignupEntity =
      SignUpEntity(name: 'john', email: 'abcd@gmail.com', password: 'abcd1234');
  const testGetMeEntity = GetMeEntity(name: 'john');
  test('initial state should be empty', () {
    expect(authBloc.state, AuthInitialState());
  });
  blocTest<AuthBloc, AuthState>(
      'should emit [Loading, LoginSuccessfullState] on Login event',
      build: () {
        when(mockLoginUseCase(const LoginParams(user: testLoginEntity)))
            .thenAnswer((_) async => const Right(null));
        return authBloc;
      },
      act: (bloc) => bloc.add(const LoginEvent(testLoginEntity)),
      wait: const Duration(milliseconds: 500),
      expect: () => [AuthLoadingState(), LoginSuccessState()]);
  blocTest<AuthBloc, AuthState>(
      'should emit [Loading, ErrorState] on Login event',
      build: () {
        when(mockLoginUseCase(const LoginParams(user: testLoginEntity)))
            .thenAnswer((_) async => Left(ServerFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(const LoginEvent(testLoginEntity)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            AuthLoadingState(),
            const AuthErrorState(message: 'Server Failure')
          ]);
  blocTest<AuthBloc, AuthState>(
      'should emit [Loading, SignUpSuccessfullState] on signUp event',
      build: () {
        when(mockSignUpUseCase(const SignUpParams(user: testSignupEntity)))
            .thenAnswer((_) async => const Right(null));
        return authBloc;
      },
      act: (bloc) => bloc.add(const SignUpEvent(testSignupEntity)),
      wait: const Duration(milliseconds: 500),
      expect: () => [AuthLoadingState(), SignUpSuccessState()]);
  blocTest<AuthBloc, AuthState>(
      'should emit [Loading, ErrorState] on SignUp event',
      build: () {
        when(mockSignUpUseCase(const SignUpParams(user: testSignupEntity)))
            .thenAnswer((_) async => Left(ServerFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(const SignUpEvent(testSignupEntity)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            AuthLoadingState(),
            const AuthErrorState(message: 'Server Failure')
          ]);
  blocTest<AuthBloc, AuthState>(
      'should emit [Loading, GetMeSuccessfullState] on GetMe event',
      build: () {
        when(mockGetMeUseCase(NoParams()))
            .thenAnswer((_) async => const Right(testGetMeEntity));
        return authBloc;
      },
      act: (bloc) => bloc.add(GetMeEvent()),
      wait: const Duration(milliseconds: 500),
      expect: () =>
          [AuthLoadingState(), const GetMeSuccessState(user: testGetMeEntity)]);
  blocTest<AuthBloc, AuthState>(
      'should emit [Loading, ErrorState] on SignUp event',
      build: () {
        when(mockGetMeUseCase(NoParams()))
            .thenAnswer((_) async => Left(ServerFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(GetMeEvent()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            AuthLoadingState(),
            const AuthErrorState(message: 'Server Failure')
          ]);
  blocTest<AuthBloc, AuthState>(
      'should emit [Loading, LogOutSuccessfull] on logout event',
      build: () {
        when(mockLogoutUseCase(NoParams()))
            .thenAnswer((_) async => const Right(null));
        return authBloc;
      },
      act: (bloc) => bloc.add(LogOutEvent()),
      wait: const Duration(milliseconds: 500),
      expect: () => [AuthLoadingState(), LogOutSuccessState()]);
  blocTest<AuthBloc, AuthState>(
      'should emit [Loading, ErrorState] on SignUp event',
      build: () {
        when(mockLogoutUseCase(NoParams()))
            .thenAnswer((_) async => Left(ServerFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(LogOutEvent()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            AuthLoadingState(),
            const AuthErrorState(message: 'Server Failure')
          ]);
}
