import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../constants/assets_path.dart';
import '../../../../core/onboarding/bloc/onboarding_bloc.dart';
import '../../../../core/onboarding/model/onboarding_model.dart';
import '../../../../utils/responsive_configuration.dart';
import '../../../../widgets/buttons/edge_button_icon.dart';
import '../../../../widgets/shimmers/shimmer_rounded_rectangle.dart';
import '../controller/onboarding_body_controller.dart';
import '../item/onboarding_item.dart';

class OnboardingBody extends StatefulWidget {
  const OnboardingBody({Key? key}) : super(key: key);

  @override
  _OnboardingBodyState createState() => _OnboardingBodyState();
}

class _OnboardingBodyState extends State<OnboardingBody> {
  late final OnboardingBodyController _onboardingController;

  List<Widget> _buildPageItems(List<OnBoardingModel> items) {
    return [
      for (final introModel in items)
        OnboardingItem(
          title: introModel.introTitle,
          description: introModel.introSubtitle,
          image: introModel.urlImage,
        ),
    ];
  }

  void _onButtonClick() {
    _onboardingController.handleNextOrFinish(
      context,
      context.read<OnboardingBloc>(),
    );
  }

  @override
  void initState() {
    super.initState();
    _onboardingController = OnboardingBodyController();
    _onboardingController.loadOnboarding(context.read<OnboardingBloc>());
    _onboardingController.markOnboardingSeen();
  }

  @override
  void dispose() {
    _onboardingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        Theme.of(context).appBarTheme.systemOverlayStyle!);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: _body()),
    );
  }

  _body() {
    return BlocBuilder<OnboardingBloc, OnBoardingState>(
      buildWhen: (previous, current) =>
          current is OnBoardingInitState ||
          current is OnBoardingLoading ||
          current is OnBoardingLoaded ||
          current is OnBoardingError,
      builder: (BuildContext context, OnBoardingState state) {
        if (state is OnBoardingError) {
          return SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: pxToSp(context, 24)),
                child: Text(
                  state.error.toString(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          );
        }

        final items = state is OnBoardingLoaded
            ? state.onBoardingList
            : <OnBoardingModel>[];
        final showShimmer = items.isEmpty;
        final indicatorCount = items.isEmpty ? 1 : items.length;

        return SafeArea(
          child: Container(
            height: 100.h,
            child: Column(
              children: [
                showShimmer
                    ? Expanded(
                        child: Container(
                          alignment: Alignment.topCenter,
                          child: ShimmerRoundedRectangle(
                            width: 100.w,
                            height: 100.w,
                            borderRadius: 0,
                          ),
                        ),
                      )
                    : Expanded(
                        child: PageView(
                          controller: _onboardingController.pageController,
                          onPageChanged: _onboardingController.onPageChanged,
                          children: _buildPageItems(items),
                        ),
                      ),
                Container(
                  padding: EdgeInsets.only(
                    left: pxToSp(context, 18),
                    right: pxToSp(context, 18),
                    bottom: pxToSp(context, 18),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: SmoothPageIndicator(
                          controller: _onboardingController.pageController,
                          count: indicatorCount,
                          effect: ExpandingDotsEffect(
                            activeDotColor: AppColors.accent_light,
                            dotColor: Theme.of(context).canvasColor,
                            dotWidth: pxToSp(context, 10),
                            dotHeight: pxToSp(context, 10),
                            expansionFactor: 3.0,
                          ),
                          onDotClicked: (page) {
                            _onboardingController.animateToPage(page);
                          },
                        ),
                      ),
                      EdgeButtonIcon(
                        icon: Assets.chevronRight,
                        onPressed: _onButtonClick,
                        sizeIcon: pxToSp(context, 14),
                        iconColor: Colors.white,
                        isFullWidth: false,
                        buttonColor: AppColors.accent_light,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
