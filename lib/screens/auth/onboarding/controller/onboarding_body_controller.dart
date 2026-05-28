import 'package:blueprint_mobile_flutter/config/routes/go_route_generator.dart';
import 'package:blueprint_mobile_flutter/config/routes/routes.dart';
import 'package:blueprint_mobile_flutter/core/onboarding/bloc/onboarding_bloc.dart';
import 'package:blueprint_mobile_flutter/core/onboarding/model/onboarding_model.dart';
import 'package:blueprint_mobile_flutter/utils/services/storage/local_storage_service.dart';
import 'package:flutter/material.dart';

/// Controller for onboarding pager, fetch, and primary navigation.
class OnboardingBodyController {
  OnboardingBodyController();

  final PageController pageController = PageController();

  int _currentPage = 0;

  int get currentPage => _currentPage;

  void loadOnboarding(OnboardingBloc bloc) {
    bloc.add(const FetchOnBoarding());
  }

  void onPageChanged(int page) {
    _currentPage = page;
  }

  void markOnboardingSeen() {
    LocalStorageService.setOnboarding(true);
  }

  void handleNextOrFinish(BuildContext context, OnboardingBloc bloc) {
    final state = bloc.state;
    final list =
        state is OnBoardingLoaded ? state.onBoardingList : <OnBoardingModel>[];

    if (list.isEmpty) {
      context.goTo(loginRoute);
      return;
    }
    if (_currentPage == list.length - 1) {
      context.goTo(loginRoute);
      return;
    }
    pageController.animateToPage(
      _currentPage + 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void animateToPage(int page) {
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void dispose() {
    pageController.dispose();
  }
}
