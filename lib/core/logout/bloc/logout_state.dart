part of 'logout_bloc.dart';

abstract class LogoutState extends Equatable {
  @override
  List<Object> get props => [];
}

class LogoutInitState extends LogoutState {}

class LogoutIdleState extends LogoutState {
  LogoutIdleState();
}

class LogoutLoading extends LogoutState {}

class LogoutLoaded extends LogoutState {
  final LogoutResponseData response;

  LogoutLoaded({required this.response});
}

class LogoutError extends LogoutState {
  final textError;

  LogoutError({this.textError});
}
