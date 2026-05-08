part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangePasswordIdleEvent extends ChangePasswordEvent {
  const ChangePasswordIdleEvent();
}

class ChangePasswordFetched extends ChangePasswordEvent {
  const ChangePasswordFetched({required this.request});

  final ChangePasswordRequest request;

  @override
  List<Object> get props => [];
}
