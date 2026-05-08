import 'package:blueprint_mobile_flutter/core/auth_token/bloc/auth_token_bloc.dart';
import 'package:blueprint_mobile_flutter/core/auth_token/repository/auth_token_repository.dart';
import 'package:blueprint_mobile_flutter/core/fcm/bloc/fcm_bloc.dart';
import 'package:blueprint_mobile_flutter/core/fcm/repository/fcm_repository.dart';
import 'package:blueprint_mobile_flutter/core/profile/bloc/profile_bloc.dart';
import 'package:blueprint_mobile_flutter/core/profile/repository/profile_repository.dart';
import 'package:blueprint_mobile_flutter/screens/home/body/home_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FcmBloc>(
          create: (BuildContext context) => FcmBloc(repository: FcmService()),
        ),
        BlocProvider<AuthTokenBloc>(
          create: (BuildContext context) =>
              AuthTokenBloc(authRepository: AuthTokenService()),
        ),
        BlocProvider<ProfileBloc>(
          create: (BuildContext context) =>
              ProfileBloc(repository: ProfileService()),
        ),
      ],
      child: HomeBody(),
    );
  }
}
