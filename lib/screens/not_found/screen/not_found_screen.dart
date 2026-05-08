import 'package:flutter/material.dart';

import '../body/not_found_body.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key, this.isShowBackButton = true});

  final bool isShowBackButton;

  @override
  Widget build(BuildContext context) {
    return NotFoundBody(isShowBackButton: isShowBackButton);
  }
}
