part of 'update_profile_bloc.dart';

abstract class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();

  @override
  List<Object> get props => [];
}

class UpdateProfileIdleEvent extends UpdateProfileEvent {
  const UpdateProfileIdleEvent();
}

class UpdateProfileFetched extends UpdateProfileEvent {
  const UpdateProfileFetched({required this.request});

  final UpdateProfileRequest request;

  @override
  List<Object> get props => [];
}
