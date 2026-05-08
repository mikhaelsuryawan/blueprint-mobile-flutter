part of 'auth_token_bloc.dart';

abstract class AuthTokenState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthTokenInitState extends AuthTokenState {}

class AuthTokenIdleState extends AuthTokenState {
  AuthTokenIdleState();
}

class AuthTokenLoading extends AuthTokenState {}

class AuthTokenLoaded extends AuthTokenState {
  final AuthTokenData? response;

  AuthTokenLoaded({required this.response});
}

class AuthTokenError extends AuthTokenState {
  final textError;

  AuthTokenError({this.textError});
}
