import 'package:equatable/equatable.dart';

import '../../domain/entity/getme_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class InitialState extends AuthState {}

class LoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

class SignUpSuccessState extends AuthState {}

class LogOutSuccessState extends AuthState {}

class GetMeSuccessState extends AuthState {
  final GetMeEntity user;

  const GetMeSuccessState({required this.user});
}

class ErrorState extends AuthState {
  final String message;

  const ErrorState({required this.message});
}
