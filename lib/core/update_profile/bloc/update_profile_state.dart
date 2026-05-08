part of 'update_profile_bloc.dart';

abstract class UpdateProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateProfileInitState extends UpdateProfileState {}

class UpdateProfileIdleState extends UpdateProfileState {
  UpdateProfileIdleState();
}

class UpdateProfileLoading extends UpdateProfileState {}

class UpdateProfileLoaded extends UpdateProfileState {
  final UpdateProfileData response;

  UpdateProfileLoaded({required this.response});
}

class UpdateProfileError extends UpdateProfileState {
  final textError;

  UpdateProfileError({this.textError});
}
