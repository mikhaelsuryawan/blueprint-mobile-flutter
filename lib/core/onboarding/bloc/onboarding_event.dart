part of 'onboarding_bloc.dart';

abstract class OnBoardingEvent extends Equatable {
  const OnBoardingEvent();

  @override
  List<Object> get props => [];
}

class FetchOnBoarding extends OnBoardingEvent {
  const FetchOnBoarding();
}
