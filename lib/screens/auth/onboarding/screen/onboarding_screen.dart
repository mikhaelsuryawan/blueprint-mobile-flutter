import 'package:blueprint_mobile_flutter/core/onboarding/repository/onboarding_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/onboarding/bloc/onboarding_bloc.dart';
import '../body/onboarding_body.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OnboardingBloc>(
          create: (BuildContext context) =>
              OnboardingBloc(repository: OnboardingService()),
        ),
      ],
      child: const OnboardingBody(),
    );
  }
}
