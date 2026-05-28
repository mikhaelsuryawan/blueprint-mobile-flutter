import 'package:blueprint_mobile_flutter/core/login/bloc/login_bloc.dart';
import 'package:blueprint_mobile_flutter/core/login/repository/login_repository.dart';
import 'package:blueprint_mobile_flutter/screens/auth/login/body/login_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (BuildContext context) =>
              LoginBloc(repository: LoginService()),
        ),
      ],
      child: LoginBody(),
    );
  }
}
