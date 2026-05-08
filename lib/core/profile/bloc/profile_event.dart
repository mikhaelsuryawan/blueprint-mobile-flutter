part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileIdleEvent extends ProfileEvent {
  const ProfileIdleEvent();
}

class ProfileFetched extends ProfileEvent {
  const ProfileFetched();

  @override
  List<Object> get props => [];
}
