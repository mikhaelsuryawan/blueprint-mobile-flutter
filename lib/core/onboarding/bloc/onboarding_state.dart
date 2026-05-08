part of 'onboarding_bloc.dart';

abstract class OnBoardingState extends Equatable {
  @override
  List<Object> get props => [];
}

class OnBoardingInitState extends OnBoardingState {}

class OnBoardingLoading extends OnBoardingState {}

class OnBoardingLoaded extends OnBoardingState {
  final List<OnBoardingModel> onBoardingList;

  OnBoardingLoaded({required this.onBoardingList});
}

class OnBoardingError extends OnBoardingState {
  final error;

  OnBoardingError({this.error});
}