import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

import '../../../../config/themes/notifiers/theme_manager.dart';
import '../../../../utils/helpers.dart';
import '../../../../utils/responsive_configuration.dart';

class OnboardingItem extends StatelessWidget {
  const OnboardingItem({
    Key? key,
    required this.title,
    required this.image,
    required this.description,
  }) : super(key: key);

  final String title, image, description;

  @override
  Widget build(BuildContext context) {
    return Helpers.isSmallScreen(context)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(child: Lottie.asset(image))
                    .animate()
                    .fadeIn(duration: 800.ms)
                    .slideX(begin: 1),
              ),
              Container(
                padding: EdgeInsets.all(pxToSp(context, 18)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.left,
                      style: AppThemeNotifier.getTextStyleFromTheme(
                        baseStyle: Theme.of(context).textTheme.titleLarge,
                      ),
                    ).animate().fadeIn(duration: 800.ms, delay: 800.ms).move(),
                    Container(
                      margin: EdgeInsets.only(
                        top: pxToSp(context, 18),
                      ),
                      child: Text(
                        description,
                        textAlign: TextAlign.left,
                        style: AppThemeNotifier.getTextStyleFromTheme(
                          baseStyle: Theme.of(context).textTheme.bodyMedium,
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 800.ms, delay: 1600.ms)
                          .move(),
                    ),
                  ],
                ),
              ),
            ],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(child: Lottie.asset(image))
                    .animate()
                    .fadeIn(duration: 800.ms)
                    .slideX(begin: 1),
              ),
              Container(
                padding: EdgeInsets.all(pxToSp(context, 18)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.left,
                      style: AppThemeNotifier.getTextStyleFromTheme(
                        baseStyle: Theme.of(context).textTheme.titleLarge,
                      ),
                    ).animate().fadeIn(duration: 800.ms, delay: 800.ms).move(),
                    Container(
                      margin: EdgeInsets.only(
                        top: pxToSp(context, 18),
                      ),
                      child: Text(
                        description,
                        textAlign: TextAlign.left,
                        style: AppThemeNotifier.getTextStyleFromTheme(
                          baseStyle: Theme.of(context).textTheme.bodyMedium,
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 800.ms, delay: 1600.ms)
                          .move(),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
