import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/sign_up/bloc/sign_up_bloc.dart';
import '../../../../core/sign_up/repository/sign_up_repository.dart';
import '../body/sign_up_body.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (BuildContext context) =>
          SignUpBloc(repository: SignUpService()),
      child: const SignUpBody(),
    );
  }
}
