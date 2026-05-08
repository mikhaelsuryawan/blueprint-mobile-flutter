import 'package:blueprint_mobile_flutter/core/auth_token/repository/auth_token_repository.dart';
import 'package:blueprint_mobile_flutter/core/refresh_token/repository/refresh_token_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/refresh_token/bloc/refresh_token_bloc.dart';
import '../body/splash_body.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RefreshTokenBloc>(
          create: (BuildContext context) => RefreshTokenBloc(
              refreshTokenRepository: RefreshTokenService(),
              authTokenRepository: AuthTokenService()),
        ),
      ],
      child: SplashBody(),
    );
  }
}
