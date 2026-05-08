part of 'fcm_bloc.dart';

abstract class FcmEvent extends Equatable {
  const FcmEvent();

  @override
  List<Object> get props => [];
}

class FcmIdleEvent extends FcmEvent {
  const FcmIdleEvent();
}

class FcmFetched extends FcmEvent {
  const FcmFetched({required this.request});

  final UpdateFcmRequest request;

  @override
  List<Object> get props => [];
}
