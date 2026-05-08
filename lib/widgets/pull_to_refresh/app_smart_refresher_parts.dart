import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../config/language/app_localizations.dart';
import '../../config/themes/app_colors.dart';
import '../../config/themes/notifiers/theme_manager.dart';
import '../../utils/responsive_configuration.dart';

/// Shared [WaterDropMaterialHeader] and [CustomFooter] for [SmartRefresher]
/// so pull-to-refresh styling stays consistent across modules.
class AppSmartRefresherParts {
  AppSmartRefresherParts._();

  static Widget waterDropHeader(BuildContext context) {
    return WaterDropMaterialHeader(
      color: AppColors.accent_light,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }

  /// [context] should be the surrounding widget [BuildContext] (e.g. State.context)
  /// for responsive sizing; the footer builder may receive a different context.
  static Widget customFooter(BuildContext context) {
    return CustomFooter(
      builder: (BuildContext? footerContext, LoadStatus? mode) {
        final ctx = footerContext ?? context;
        final Widget body;
        if (mode == LoadStatus.idle) {
          body = Text(
            GetAppLocalizations(ctx).pullUpToLoad,
            style: AppThemeNotifier.getTextStyleFromTheme(
              baseStyle: Theme.of(ctx).textTheme.bodySmall,
            ),
          );
        } else if (mode == LoadStatus.loading) {
          body = LoadingAnimationWidget.fourRotatingDots(
            color: AppColors.accent_light,
            size: pxToSp(context, 24),
          );
        } else if (mode == LoadStatus.failed) {
          body = Text(
            GetAppLocalizations(ctx).loadFailed,
            style: AppThemeNotifier.getTextStyleFromTheme(
              baseStyle: Theme.of(ctx).textTheme.bodySmall,
            ),
          );
        } else if (mode == LoadStatus.canLoading) {
          body = const Text('');
        } else {
          body = const Text('');
        }
        return Container(
          margin: EdgeInsets.all(pxToSp(context, 16)),
          child: Center(child: body),
        );
      },
    );
  }
}
