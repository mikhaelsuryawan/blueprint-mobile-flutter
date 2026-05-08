part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class SignUpIdleEvent extends SignUpEvent {
  const SignUpIdleEvent();
}

class SignUpFetched extends SignUpEvent {
  const SignUpFetched({required this.request});

  final SignUpRequest request;

  @override
  List<Object?> get props => [request];
}
