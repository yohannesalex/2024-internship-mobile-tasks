import 'package:bloc/bloc.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/getme.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/sign_up.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetMeUseCase _getMeUsecase;
  final SignUpUseCase _signUpUseCase;
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthBloc(
    this._getMeUsecase,
    this._loginUseCase,
    this._signUpUseCase,
    this._logoutUseCase,
  ) : super(InitialState()) {
    on<GetMeEvent>(
      (event, emit) async {
        emit(LoadingState());
        final result = await _getMeUsecase(NoParams());
        result.fold((failure) {
          emit(const ErrorState(message: 'unable to load'));
        }, (data) {
          emit(GetMeSuccessState(user: data));
        });
      },
      // transformer: debounce(const Duration(milliseconds: 300))
    );
    on<SignUpEvent>((event, emit) async {
      emit(LoadingState());
      final result = await _signUpUseCase(SignUpParams(user: event.user));

      result.fold((failure) {
        emit(const ErrorState(message: 'unable to load'));
      }, (data) {
        emit(SignUpSuccessState());
      });
    });
    on<LoginEvent>((event, emit) async {
      emit(LoadingState());
      final result = await _loginUseCase(LoginParams(user: event.user));

      result.fold((failure) {
        emit(const ErrorState(message: 'unable to load'));
      }, (data) {
        emit(LoginSuccessState());
      });
    });
    on<LogOutEvent>((event, emit) async {
      emit(LoadingState());
      final result = await _logoutUseCase(NoParams());
      result.fold((failure) {
        emit(const ErrorState(message: 'unable to load'));
      }, (data) {
        emit(LogOutSuccessState());
      });
    });
  }
}

// EventTransformer<GetSingleProductEvent> debounce<T>(Duration duration) {
//   return (event, mapper) => event.debounceTime(duration).flatMap(mapper);
// }
