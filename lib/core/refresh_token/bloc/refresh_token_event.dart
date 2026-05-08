part of 'refresh_token_bloc.dart';

abstract class RefreshTokenEvent extends Equatable {
  const RefreshTokenEvent();

  @override
  List<Object> get props => [];
}

class RefreshTokenIdleEvent extends RefreshTokenEvent {
  const RefreshTokenIdleEvent();
}

class RefreshTokenFetched extends RefreshTokenEvent {
  const RefreshTokenFetched({required this.request});

  final AuthTokenRequest request;

  @override
  List<Object> get props => [request];
}

class AuthTokenFetched extends RefreshTokenEvent {
  const AuthTokenFetched({required this.request});

  final AuthTokenRequest request;

  @override
  List<Object> get props => [request];
}
