part of 'fcm_bloc.dart';

abstract class FcmState extends Equatable {
  const FcmState();

  @override
  List<Object> get props => [];
}

class FcmInitState extends FcmState {}

class FcmIdleState extends FcmState {
  FcmIdleState();
}

class FcmLoading extends FcmState {}

class FcmLoaded extends FcmState {
  final UpdateFcmResponseData? response;

  FcmLoaded({required this.response});
}

class FcmError extends FcmState {
  final textError;

  FcmError({this.textError});
}
