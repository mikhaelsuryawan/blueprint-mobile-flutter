import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/change_password/bloc/change_password_bloc.dart';
import '../../../../core/change_password/repository/change_password_repository.dart';
import '../body/change_password_body.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChangePasswordBloc>(
          create: (BuildContext context) =>
              ChangePasswordBloc(repository: ChangePasswordService()),
        ),
      ],
      child: ChangePasswordBody(),
    );
  }
}
