part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitState extends ProfileState {}

class ProfileIdleState extends ProfileState {
  ProfileIdleState();
}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileDetailData response;

  ProfileLoaded({required this.response});
}

class ProfileError extends ProfileState {
  final textError;

  ProfileError({this.textError});
}
