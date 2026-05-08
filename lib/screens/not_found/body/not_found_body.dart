import 'package:blueprint_mobile_flutter/config/language/app_localizations.dart';
import 'package:blueprint_mobile_flutter/config/themes/notifiers/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

import '../../../config/routes/go_route_generator.dart';
import '../../../constants/assets_path.dart';
import '../../../utils/responsive_configuration.dart';
import '../../../widgets/buttons/edge_button_small.dart';

class NotFoundBody extends StatefulWidget {
  const NotFoundBody({super.key, this.isShowBackButton = true});
  final bool isShowBackButton;
  @override
  State<NotFoundBody> createState() => _NotFoundBodyState();
}

class _NotFoundBodyState extends State<NotFoundBody> {
  Widget _body() {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(pxToSp(context, 16)),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(pxToSp(context, 16)),
                      child: Lottie.asset(Assets.failedLottie,
                          width: pxToSp(context, 128),
                          height: pxToSp(context, 128)),
                    ).animate().fadeIn(duration: 600.ms).scale(),
                    Text(
                      GetAppLocalizations(context).notFound,
                      textAlign: TextAlign.center,
                      style: AppThemeNotifier.getTextStyleFromTheme(
                        baseStyle: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ).animate().fadeIn(duration: 600.ms, delay: 600.ms).move(),
                    if (widget.isShowBackButton)
                      Container(
                        margin: EdgeInsets.only(top: pxToSp(context, 18)),
                        child: EdgeButtonSmall(
                            text: GetAppLocalizations(context).back,
                            onPressed: () {
                              context.popRoute();
                            }),
                      )
                          .animate()
                          .fadeIn(duration: 600.ms, delay: 1200.ms)
                          .move(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }
}
