import 'package:flutter/material.dart';

import '../../../core/models/arguments/arguments_main.dart';
import '../body/main_body.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key, required this.argumentsMain}) : super(key: key);
  final ArgumentsMain argumentsMain;

  @override
  Widget build(BuildContext context) {
    return MainBody(argumentsMain: argumentsMain,);
  }
}
