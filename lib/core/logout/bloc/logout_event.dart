part of 'logout_bloc.dart';

abstract class LogoutEvent extends Equatable {
  const LogoutEvent();

  @override
  List<Object> get props => [];
}

class LogoutIdleEvent extends LogoutEvent {
  const LogoutIdleEvent();
}

class LogoutFetched extends LogoutEvent {
  const LogoutFetched();

  @override
  List<Object> get props => [];
}
