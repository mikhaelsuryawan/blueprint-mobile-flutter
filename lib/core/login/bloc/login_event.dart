part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginIdleEvent extends LoginEvent {
  const LoginIdleEvent();
}

class LoginFetched extends LoginEvent {
  const LoginFetched({required this.request});

  final LoginRequest request;

  @override
  List<Object> get props => [];
}
