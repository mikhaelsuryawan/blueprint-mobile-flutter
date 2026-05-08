part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitState extends LoginState {}

class LoginIdleState extends LoginState {
  LoginIdleState();
}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final LoginData? response;

  LoginLoaded({required this.response});
}

class LoginError extends LoginState {
  final textError;

  LoginError({this.textError});
}
