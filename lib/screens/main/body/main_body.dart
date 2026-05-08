import 'dart:io';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../config/language/app_localizations.dart';
import '../../../config/themes/notifiers/theme_manager.dart';
import '../../../config/routes/go_route_generator.dart';
import '../../../config/themes/app_colors.dart';
import '../../../constants/assets_path.dart';
import '../../../core/models/arguments/arguments_main.dart';
import '../../../utils/helpers.dart';
import '../../../utils/responsive_configuration.dart';
import '../../../widgets/dialog/dialog_exit_app.dart';
import '../../ai_chat/screen/ai_chat_screen.dart';
import '../../home/screen/home_screen.dart';
import '../../my_career/screen/my_career_screen.dart';
import '../../profile/screen/profile_screen.dart';

class MainBody extends StatefulWidget {
  const MainBody({Key? key, required this.argumentsMain}) : super(key: key);
  final ArgumentsMain argumentsMain;

  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  List<Widget> childrenMenu = [];
  AnimationController? _animationController;
  Animation<double>? animation;
  CurvedAnimation? curve;

  final iconList = <String>[
    Assets.homeDeactivate,
    Assets.historyDeactivate,
    Assets.historyDeactivate,
    // Assets.notificationDeactivate,
    Assets.profileDeactivate,
  ];

  final iconActivateList = <String>[
    Assets.homeActivate,
    Assets.historyActivate,
    Assets.historyActivate,
    // Assets.notificationActivate,
    Assets.profileActivate,
  ];

  List<String> textList = [];

  @override
  void initState() {
    super.initState();

    childrenMenu = const [
      HomeScreen(),
      MyCareerScreen(),
      AiChatScreen(),
      ProfileScreen(),
    ];
    _currentIndex = widget.argumentsMain.currentIndex;

    // Your existing notch/corners animation
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController!,
      curve: const Interval(0.5, 1.0, curve: Curves.fastLinearToSlowEaseIn),
    );
    animation = Tween<double>(begin: 0, end: 1).animate(curve!);

    Future.delayed(
      Duration(seconds: 1),
      () {
        if (mounted && _animationController != null) {
          _animationController!.forward();
        }
      },
    );
  }

  @override
  void dispose() {
    _animationController?.stop();
    _animationController?.dispose();
    _animationController = null;
    animation = null;
    curve = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    textList = <String>[
      GetAppLocalizations(context).home,
      GetAppLocalizations(context).myCareer,
      GetAppLocalizations(context).aiChat,
      GetAppLocalizations(context).profile,
    ];

    final _scaffoldKey = GlobalKey<ScaffoldState>();
    SystemChrome.setSystemUIOverlayStyle(
        Theme.of(context).appBarTheme.systemOverlayStyle!);

    // Height: 10.h if portrait OR not tablet, 17.h if landscape OR tablet
    final bottomNavHeight = Helpers.isSmallScreen(context)
        ? pxToSp(context, 70)
        : pxToSp(context, 70);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (_currentIndex == 0) {
          await showDialog(
            context: context,
            builder: (context) {
              return DialogExitApp(onSubmit: () {
                exit(0);
              }, onCancel: () {
                context.popRoute(false);
              });
            },
          );
        }
        if (mounted) {
          setState(() {
            _currentIndex = 0;
          });
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        // BODY: Animate between pages
        body: childrenMenu[_currentIndex],

        // NAV BAR: Animated icons/text + your existing notch animation
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          leftCornerRadius: pxToSp(context, 18),
          rightCornerRadius: pxToSp(context, 18),
          itemCount: iconList.length,
          tabBuilder: (int index, bool isActive) {
            final Color activeColor =
                Theme.of(context).textTheme.titleMedium?.color ??
                    AppColors.white_FFFFFF;
            final Color activeIconColor =
                Theme.of(context).textTheme.labelMedium?.color ??
                    AppColors.white_FFFFFF;
            final Color inactiveColor =
                Theme.of(context).textTheme.labelMedium?.color ??
                    AppColors.white_FFFFFF;

            // Icon bump + text fade/weight transition
            return TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 1.0, end: isActive ? 1.15 : 0.9),
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutBack,
              builder: (context, scale, _) {
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 180),
                  opacity: isActive ? 1 : 0.75,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scale: scale,
                        child: isActive
                            ? Container(
                                width: pxToSp(context, 34),
                                height: pxToSp(context, 34),
                                padding: EdgeInsets.all(pxToSp(context, 8)),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(
                                      pxToSp(context, 12)),
                                ),
                                child: SvgPicture.asset(
                                  iconList[index],
                                  width: pxToSp(context, 30),
                                  height: pxToSp(context, 30),
                                  colorFilter: ColorFilter.mode(
                                    isActive ? activeIconColor : inactiveColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              )
                            : SvgPicture.asset(
                                iconList[index],
                                width: pxToSp(context, 28),
                                height: pxToSp(context, 28),
                                colorFilter: ColorFilter.mode(
                                  isActive ? activeIconColor : inactiveColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                      ),
                      SizedBox(height: pxToSp(context, 12)),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOut,
                        style: isActive
                            ? AppThemeNotifier.getTextStyleFromTheme(
                                color: activeColor,
                                baseStyle:
                                    Theme.of(context).textTheme.bodyLarge,
                              )
                            : AppThemeNotifier.getTextStyleFromTheme(
                                baseStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                              ),
                        child: Text(
                          textList[index],
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          backgroundColor:
              Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          elevation: 0,
          activeIndex: _currentIndex,
          height: bottomNavHeight,
          splashColor: AppColors.white_FFFFFF,
          notchAndCornersAnimation: animation,
          splashSpeedInMilliseconds: 300,
          notchSmoothness: NotchSmoothness.verySmoothEdge,
          gapLocation: GapLocation.none,
          onTap: (index) {
            if (mounted) {
              setState(() {
                _currentIndex = index;
              });
            }
          },
        ),
      ),
    );
  }
}
