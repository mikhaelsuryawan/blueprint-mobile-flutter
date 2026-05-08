import 'package:blueprint_mobile_flutter/core/update_profile/repository/update_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/update_profile/bloc/update_profile_bloc.dart';
import '../body/update_profile_body.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UpdateProfileBloc>(
          create: (BuildContext context) =>
              UpdateProfileBloc(repository: UpdateProfileService()),
        ),
      ],
      child: UpdateProfileBody(),
    );
  }
}
