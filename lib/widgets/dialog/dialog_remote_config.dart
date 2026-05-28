import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:store_redirect/store_redirect.dart';

import '../../config/language/app_localizations.dart';
import '../../config/themes/app_colors.dart';
import '../../config/themes/notifiers/theme_manager.dart';
import '../buttons/edge_border_button_medium.dart';
import '../buttons/edge_button_medium.dart';
import '../../utils/responsive_configuration.dart';

/// Remote Config Update Dialog
/// Shows update dialog for force or recommended updates
class DialogRemoteConfig extends StatelessWidget {
  const DialogRemoteConfig({
    Key? key,
    required this.isForceUpdate,
    required this.updateMessage,
    required this.iOSAppId,
    required this.packageName,
    this.onLater,
    this.onUpdate,
  }) : super(key: key);

  final bool isForceUpdate;
  final String updateMessage;
  final String iOSAppId;
  final String packageName;
  final VoidCallback? onLater;
  final VoidCallback? onUpdate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(pxToSp(context, 25)),
          topRight: Radius.circular(pxToSp(context, 25)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Title
          Container(
            margin: EdgeInsets.only(
              left: pxToSp(context, 25),
              right: pxToSp(context, 25),
              bottom: 0,
              top: pxToSp(context, 25),
            ),
            child: Text(
              GetAppLocalizations(context).newApplicationAvailable,
              style: AppThemeNotifier.getTextStyleFromTheme(
                baseStyle: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),

          // Message
          Container(
            margin: EdgeInsets.all(pxToSp(context, 25)),
            child: Text(
              updateMessage.isNotEmpty
                  ? updateMessage
                  : GetAppLocalizations(context).remoteUpdateDefaultMessage,
              style: AppThemeNotifier.getTextStyleFromTheme(
                baseStyle: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),

          // Buttons
          Row(
            children: [
              // Later button (only shown for recommend update)
              Expanded(
                flex: isForceUpdate ? 0 : 1,
                child: Visibility(
                  visible: !isForceUpdate,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: pxToSp(context, 25),
                      right: 8.sp,
                      bottom: pxToSp(context, 25),
                    ),
                    child: EdgeBorderButtonMedium(
                      borderColor: AppColors.accent_light,
                      textColor: AppColors.accent_light,
                      buttonColor: Theme.of(context).colorScheme.surface,
                      text: GetAppLocalizations(context).later,
                      onPressed: () {
                        Navigator.of(context).pop(true);
                        onLater?.call();
                      },
                    ),
                  ),
                ),
              ),

              // Update button
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(
                    left: isForceUpdate ? pxToSp(context, 25) : 8.sp,
                    right: pxToSp(context, 25),
                    bottom: pxToSp(context, 25),
                  ),
                  child: EdgeButtonMedium(
                    textColor: AppColors.white_FFFFFF,
                    text: GetAppLocalizations(context).update,
                    onPressed: () {
                      _handleUpdate(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Handle update button press
  void _handleUpdate(BuildContext context) {
    try {
      // Redirect to app store
      StoreRedirect.redirect(
        androidAppId: packageName.isNotEmpty ? packageName : null,
        iOSAppId: iOSAppId.isNotEmpty ? iOSAppId : null,
      );

      // Call update callback if provided
      onUpdate?.call();

      // For force update, don't close dialog
      // For recommend update, close after redirect
      if (!isForceUpdate) {
        Navigator.of(context).pop(false);
      }
    } catch (e) {
      debugPrint('❌ Error redirecting to app store: $e');
      // Show error or handle gracefully
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            GetAppLocalizations(context).unableToOpenAppStore,
            style: AppThemeNotifier.getTextStyleFromTheme(
              baseStyle: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}

/// Show remote config update dialog
///
/// [isForceUpdate] - If true, user cannot dismiss and must update
/// [updateMessage] - Message to display to user
/// [iOSAppId] - iOS App Store ID
/// [packageName] - Android package name
/// [onLater] - Callback when user taps "Later" (only for recommend update)
/// [onUpdate] - Callback when user taps "Update"
///
/// Returns true if user tapped "Later", false if dialog was closed
Future<bool?> showDialogRemoteConfig({
  required BuildContext context,
  required bool isForceUpdate,
  required String updateMessage,
  required String iOSAppId,
  required String packageName,
  VoidCallback? onLater,
  VoidCallback? onUpdate,
}) async {
  try {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isDismissible: !isForceUpdate,
      backgroundColor: Colors.transparent,
      enableDrag: !isForceUpdate,
      builder: (BuildContext bc) {
        return DialogRemoteConfig(
          isForceUpdate: isForceUpdate,
          updateMessage: updateMessage,
          iOSAppId: iOSAppId,
          packageName: packageName,
          onLater: onLater,
          onUpdate: onUpdate,
        );
      },
    );

    // Handle result
    if (result == null && isForceUpdate) {
      // Force update - exit app if user tries to dismiss
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      return false;
    }

    return result;
  } catch (e) {
    debugPrint('❌ Error showing remote config dialog: $e');
    return false;
  }
}
