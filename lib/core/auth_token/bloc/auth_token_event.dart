part of 'auth_token_bloc.dart';

abstract class AuthTokenEvent extends Equatable {
  const AuthTokenEvent();

  @override
  List<Object> get props => [];
}

class AuthTokenIdleEvent extends AuthTokenEvent {
  const AuthTokenIdleEvent();
}

class AuthTokenFetched extends AuthTokenEvent {
  const AuthTokenFetched({required this.request});

  final AuthTokenRequest request;

  @override
  List<Object> get props => [];
}
