part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpInitState extends SignUpState {}

class SignUpIdleState extends SignUpState {
  SignUpIdleState();
}

class SignUpLoading extends SignUpState {}

class SignUpLoaded extends SignUpState {
  SignUpLoaded();
}

class SignUpError extends SignUpState {
  final String? textError;

  SignUpError({this.textError});
}
