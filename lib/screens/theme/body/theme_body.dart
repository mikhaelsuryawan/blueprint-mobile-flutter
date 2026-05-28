import 'package:blueprint_mobile_flutter/config/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../../../config/language/app_localizations.dart';
import '../../../config/language/language_manager.dart';
import '../../../config/themes/notifiers/theme_manager.dart';
import '../../../core/models/language/language_model.dart';
import '../../../utils/responsive_configuration.dart';
import '../../../widgets/default_appbar.dart';
import '../controller/language_controller.dart';
import '../controller/theme_controller.dart';

class ThemeBody extends StatefulWidget {
  const ThemeBody({Key? key}) : super(key: key);

  @override
  _ThemeBodyState createState() => _ThemeBodyState();
}

class _ThemeBodyState extends State<ThemeBody> {
  /// Controllers
  late final LanguageController _languageController;
  late final ThemeController _themeController;
  late final AppLanguageNotifier _languageNotifier;
  late final AppThemeNotifier _themeNotifier;

  @override
  void initState() {
    super.initState();

    // Get notifiers from context
    _languageNotifier =
        Provider.of<AppLanguageNotifier>(context, listen: false);
    _themeNotifier = Provider.of<AppThemeNotifier>(context, listen: false);

    // Initialize controllers
    _languageController = LanguageController(
      languageNotifier: _languageNotifier,
      context: context,
    );
    _themeController = ThemeController(
      themeNotifier: _themeNotifier,
    );
  }

  @override
  void dispose() {
    _languageController.dispose();
    _themeController.dispose();
    super.dispose();
  }

  Widget _widgetButtonLanguage(LanguageModel data, int index) {
    return ListenableBuilder(
      listenable: _languageController,
      builder: (context, _) {
        final isSelected = _languageController.isLanguageSelected(index);

        return GestureDetector(
          onTap: () {
            _languageController.selectLanguage(index);
          },
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: isSelected
                          ? AppColors.accent_light
                          : Theme.of(context).cardColor),
                  borderRadius:
                      BorderRadius.all(Radius.circular(pxToSp(context, 12)))),
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 0.0),
                color: isSelected
                    ? AppColors.accent_light
                    : Theme.of(context).cardColor,
                elevation: pxToSp(context, 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(pxToSp(context, 12)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: pxToSp(context, 14),
                      vertical: pxToSp(context, 14)),
                  child: Text(
                    data.name,
                    style: AppThemeNotifier.getTextStyleFromTheme(
                      color: isSelected
                          ? AppColors.white_FFFFFF
                          : Theme.of(context).textTheme.bodyMedium?.color,
                      baseStyle: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              )),
        );
      },
    );
  }

  Widget _body() {
    return Container(
      padding: EdgeInsets.only(
          left: pxToSp(context, 18),
          right: pxToSp(context, 18),
          top: pxToSp(context, 18)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              GetAppLocalizations(context).chooseLanguage,
              textAlign: TextAlign.left,
              style: AppThemeNotifier.getTextStyleFromTheme(
                baseStyle: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          ListenableBuilder(
            listenable: _languageController,
            builder: (context, _) {
              return MasonryGridView.count(
                padding: EdgeInsets.only(
                  top: pxToSp(context, 18),
                ),
                crossAxisCount: 2,
                mainAxisSpacing: pxToSp(context, 18),
                crossAxisSpacing: pxToSp(context, 18),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: _languageController.languageList.length,
                itemBuilder: (context, index) {
                  return _widgetButtonLanguage(
                      _languageController.languageList[index], index);
                },
              );
            },
          ),
          SizedBox(
            height: pxToSp(context, 22),
          ),
          ListenableBuilder(
            listenable: _themeController,
            builder: (context, _) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      child: Text(
                        GetAppLocalizations(context).darkMode,
                        textAlign: TextAlign.left,
                        style: AppThemeNotifier.getTextStyleFromTheme(
                          baseStyle: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ),
                  FlutterSwitch(
                    height: pxToSp(context, 24),
                    width: pxToSp(context, 50),
                    toggleSize: pxToSp(context, 16),
                    value: _themeController.isDarkMode,
                    showOnOff: false,
                    activeColor: AppColors.accent_light,
                    activeTextColor: AppColors.white_FFFFFF,
                    onToggle: (val) {
                      _themeController.toggleDarkMode();
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: DefaultAppBar(
        context: context,
        textTitle: GetAppLocalizations(context).settings,
        showBackButton: true,
      ),
      body: _body(),
    );
  }
}
