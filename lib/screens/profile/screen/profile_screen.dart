import 'package:blueprint_mobile_flutter/core/logout/bloc/logout_bloc.dart';
import 'package:blueprint_mobile_flutter/core/logout/repository/logout_repository.dart';
import 'package:blueprint_mobile_flutter/core/profile/bloc/profile_bloc.dart';
import 'package:blueprint_mobile_flutter/core/profile/repository/profile_repository.dart';
import 'package:blueprint_mobile_flutter/screens/profile/body/profile_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LogoutBloc>(
          create: (BuildContext context) =>
              LogoutBloc(repository: LogoutService()),
        ),
        BlocProvider<ProfileBloc>(
          create: (BuildContext context) =>
              ProfileBloc(repository: ProfileService()),
        ),
      ],
      child: ProfileBody(),
    );
  }
}
