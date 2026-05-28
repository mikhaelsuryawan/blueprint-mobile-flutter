part of 'change_password_bloc.dart';

abstract class ChangePasswordState extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangePasswordInitState extends ChangePasswordState {}

class ChangePasswordIdleState extends ChangePasswordState {
  ChangePasswordIdleState();
}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordLoaded extends ChangePasswordState {
  final ChangePasswordResponseData? response;

  ChangePasswordLoaded({required this.response});
}

class ChangePasswordError extends ChangePasswordState {
  final textError;

  ChangePasswordError({this.textError});
}
