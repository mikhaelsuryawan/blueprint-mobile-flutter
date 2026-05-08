import 'package:flutter/material.dart';

import '../config/routes/go_route_generator.dart';
import '../config/themes/notifiers/theme_manager.dart';
import '../utils/responsive_configuration.dart';

// All appbar in app using this widget
class DefaultAppBar extends AppBar {
  DefaultAppBar({
    this.textTitle = '',
    required this.context,
    this.showBackButton = true,
    this.centerTitle = true,
    this.actions,
    this.onPressed,
  }) : super(
          elevation: pxToSp(context, 10),
          shadowColor:
              Theme.of(context).colorScheme.shadow.withValues(alpha: 0.6),
          systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(pxToSp(context, 18)),
            ),
          ),
          leading: Visibility(
            visible: showBackButton,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
              ),
              onPressed:
                  onPressed == null ? () => context.popRoute() : onPressed,
            ),
          ),
          centerTitle: centerTitle,
          title: Text(
            textTitle,
            overflow: TextOverflow.ellipsis,
            style: AppThemeNotifier.getTextStyleFromTheme(
              baseStyle: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          actions: actions,
        );

  final String textTitle;
  final BuildContext context;
  final List<Widget>? actions;
  final bool showBackButton;
  final bool centerTitle;
  final VoidCallback? onPressed;
}
