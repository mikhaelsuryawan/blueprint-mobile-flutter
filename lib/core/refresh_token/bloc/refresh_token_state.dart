part of 'refresh_token_bloc.dart';

abstract class RefreshTokenState extends Equatable {
  @override
  List<Object> get props => [];
}

class RefreshTokenInitState extends RefreshTokenState {}

class RefreshTokenIdleState extends RefreshTokenState {
  RefreshTokenIdleState();
}

class RefreshTokenLoading extends RefreshTokenState {}

class RefreshTokenLoaded extends RefreshTokenState {
  final AuthTokenResponse response;

  RefreshTokenLoaded({required this.response});
}

class RefreshTokenError extends RefreshTokenState {
  final textError;

  RefreshTokenError({this.textError});
}
