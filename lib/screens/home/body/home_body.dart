import 'package:blueprint_mobile_flutter/config/routes/go_route_generator.dart';
import 'package:blueprint_mobile_flutter/screens/home/item/project_card.dart';
import 'package:blueprint_mobile_flutter/widgets/buttons/oval_button_small.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:sizer/sizer.dart';

import '../../../config/language/app_localizations.dart';
import '../../../config/routes/routes.dart';
import '../../../config/themes/notifiers/theme_manager.dart';
import '../../../core/fcm/bloc/fcm_bloc.dart';
import '../../../core/models/menu/menu_model.dart';
import '../../../core/profile/bloc/profile_bloc.dart';
import '../../../utils/helpers.dart';
import '../../../utils/responsive_configuration.dart';
import '../../../widgets/images/image_preview.dart';
import '../../../widgets/images/image_profile_extended.dart';
import '../../../widgets/pull_to_refresh/app_smart_refresher_parts.dart';
import '../../../widgets/shimmers/shimmer_rounded_rectangle.dart';
import '../controller/home_fcm_controller.dart';
import '../controller/home_profile_controller.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody>
    with SingleTickerProviderStateMixin {
  /// Controllers
  late final HomeFcmController _homeFcmController;
  late final HomeProfileController _homeProfileController;
  late final FcmBloc _fcmBloc;
  late final ProfileBloc _profileBloc;

  late final AnimationController _gridCtrl;

  /// Set before disposing [HomeProfileController] so late bloc emissions are ignored.
  bool _ignoreProfileBlocCallbacks = false;

  List<MenuModel> _menuModel = [];

  // --- Add this model inside _HomeBodyState ---
  final _projects = <ProjectCardData>[
    ProjectCardData(
      date: DateTime(2022, 5, 30),
      title: 'Mobile App',
      category: 'E - Commerce',
      progress: 0.50,
      icon: Icons.phone_iphone,
      isPrimary: true, // the dark/hero card (top-left)
    ),
    ProjectCardData(
      date: DateTime(2022, 5, 30),
      title: 'Dashboard',
      category: 'Retail',
      progress: 0.80,
      icon: Icons.dashboard_customize_outlined,
    ),
    ProjectCardData(
      date: DateTime(2022, 5, 30),
      title: 'Banner',
      category: 'Marketing',
      progress: 0.40,
      icon: Icons.image_outlined,
    ),
    ProjectCardData(
      date: DateTime(2022, 5, 30),
      title: 'UI/UX',
      category: 'Task Manager',
      progress: 0.85,
      icon: Icons.design_services_outlined,
    ),
  ];

  @override
  void initState() {
    super.initState();

    // Initialize blocs
    _fcmBloc = context.read<FcmBloc>();
    _profileBloc = context.read<ProfileBloc>();

    // Initialize controllers
    _homeFcmController = HomeFcmController(
      fcmBloc: _fcmBloc,
    );
    _homeProfileController = HomeProfileController(
      profileBloc: _profileBloc,
    );

    _menuModel.addAll(MenuModel.getData());

    _gridCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();

    // Initialize controller (checks login and loads FCM)
    _homeFcmController.initialize();
  }

  @override
  void dispose() {
    _gridCtrl.dispose();
    _ignoreProfileBlocCallbacks = true;
    _homeProfileController.dispose();
    _homeFcmController.dispose();
    super.dispose();
  }

  Widget _widgetHeaderLoading() {
    final avatar = pxToSp(context, 64);
    return Container(
      padding: EdgeInsets.all(pxToSp(context, 18)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ShimmerRoundedRectangle(
            width: avatar,
            height: avatar,
            borderRadius: avatar / 2,
          ),
          SizedBox(width: pxToSp(context, 18)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerRoundedRectangle(
                  width: MediaQuery.of(context).size.width * 0.52,
                  height: pxToSp(context, 22),
                  borderRadius: pxToSp(context, 8),
                ),
                SizedBox(height: pxToSp(context, 8)),
                ShimmerRoundedRectangle(
                  width: MediaQuery.of(context).size.width * 0.36,
                  height: pxToSp(context, 14),
                  borderRadius: pxToSp(context, 8),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _widgetHeader() {
    const heroTag = 'profileImageHeroHome';
    return ListenableBuilder(
      listenable: _homeProfileController,
      builder: (context, _) {
        if (_homeProfileController.isLoading &&
            !_homeProfileController.hasProfileData) {
          return _widgetHeaderLoading();
        }

        final imageUrl = _homeProfileController.profilePictureUrl;
        final displayName = _homeProfileController.displayName;
        final jobTitle = _homeProfileController.jobTitle;

        return Container(
          padding: EdgeInsets.all(pxToSp(context, 18)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (imageUrl.isEmpty) return;
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          opaque: false,
                          barrierColor: Colors.black.withValues(alpha: 0.85),
                          pageBuilder: (_, __, ___) => ImagePreview(
                            imageUrl: imageUrl,
                            heroTag: heroTag,
                          ),
                        ),
                      );
                    },
                    child: ImageProfileExtended(
                      imageUrl: imageUrl,
                      borderRadius: pxToSp(context, 64),
                      useShimmer: true,
                      fit: BoxFit.cover,
                      height: pxToSp(context, 64),
                      width: pxToSp(context, 64),
                    ).animate().fadeIn(duration: 600.ms).scaleXY(),
                  ),
                  SizedBox(width: pxToSp(context, 18)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          displayName,
                          style: AppThemeNotifier.getTextStyleFromTheme(
                            baseStyle: Theme.of(context).textTheme.titleLarge,
                          ),
                        ).animate().fadeIn(duration: 600.ms).move(),
                        SizedBox(height: pxToSp(context, 8)),
                        Text(
                          jobTitle,
                          style: AppThemeNotifier.getTextStyleFromTheme(
                            baseStyle: Theme.of(context).textTheme.labelMedium,
                          ),
                        )
                            .animate()
                            .fadeIn(duration: 600.ms, delay: 600.ms)
                            .move(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _welcomeCard() {
    return Container(
      margin: EdgeInsets.fromLTRB(
          pxToSp(context, 18), 0, pxToSp(context, 18), pxToSp(context, 8)),
      padding: EdgeInsets.all(pxToSp(context, 18)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
        borderRadius: BorderRadius.circular(pxToSp(context, 12)),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.15),
            blurRadius: 25,
            offset: const Offset(0, -3),
          ),
        ],
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  GetAppLocalizations(context).homeWelcomeTitle,
                  style: AppThemeNotifier.getTextStyleFromTheme(
                    baseStyle: Theme.of(context).textTheme.titleLarge,
                  ),
                ).animate().fadeIn(duration: 600.ms, delay: 400.ms).move(),
                SizedBox(height: pxToSp(context, 8)),
                Text(
                  GetAppLocalizations(context).homeWelcomeSubtitle,
                  style: AppThemeNotifier.getTextStyleFromTheme(
                    baseStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                ).animate().fadeIn(duration: 600.ms, delay: 600.ms).move(),
              ],
            ),
          ),
          // Right small illustration placeholder (keep simple)
          Icon(Icons.desktop_windows_outlined,
                  size: pxToSp(context, 28),
                  color: Theme.of(context).iconTheme.color)
              .animate()
              .fadeIn(duration: 600.ms, delay: 600.ms)
              .move()
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).move();
  }

  Widget _ongoingHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: pxToSp(context, 18), vertical: pxToSp(context, 12.5)),
      child: Row(
        children: [
          Expanded(
            child: Text(
              GetAppLocalizations(context).homeOngoingProjects,
              style: AppThemeNotifier.getTextStyleFromTheme(
                baseStyle: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ).animate().fadeIn(duration: 600.ms).slideX(),
          OvalButtonSmall(
            paddingContent: EdgeInsets.symmetric(
                horizontal: pxToSp(context, 14), vertical: pxToSp(context, 7)),
            text: GetAppLocalizations(context).viewAll,
            onPressed: () {
              context.pushTo(notFoundRoute);
            },
          ).animate().fadeIn(duration: 600.ms).slideX(begin: 1),
        ],
      ),
    );
  }

  Widget _projectsGrid() {
    // Check if device is tablet and orientation (reactive to changes)
    final crossAxisCount = Helpers.isSmallScreen(context) ? 2 : 3;
    final childAspectRatio = 0.98;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: pxToSp(context, 18)),
      child: GridView.builder(
        itemCount: _projects.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: pxToSp(context, 18),
          crossAxisSpacing: pxToSp(context, 18),
          childAspectRatio: childAspectRatio,
        ),
        itemBuilder: (_, i) {
          final isLeft = i % crossAxisCount == 0; // left col => true
          final row =
              i ~/ crossAxisCount; // Calculate row based on crossAxisCount

          // Stagger: each row starts a bit later
          final double start = (row * 0.2).clamp(0.0, 1.0);
          final double end = (start + 1).clamp(0.0, 1.0);

          final slide = Tween<Offset>(
            begin: Offset(isLeft ? -0.25 : 0.25, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: _gridCtrl,
              curve: Interval(start, end, curve: Curves.easeOutCubic),
            ),
          );

          final fade = CurvedAnimation(
            parent: _gridCtrl,
            curve: Interval(start, end, curve: Curves.easeOut),
          );

          return FadeTransition(
            opacity: fade,
            child: SlideTransition(
              position: slide,
              child: ProjectCard(
                data: _projects[i],
                onTap: () {
                  // TODO: navigate to project detail if needed
                },
              ),
            ),
          );
        },
      ),
    );
  }

  _body() {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
      onRefresh: () async {
        _homeProfileController.loadProfile();
        await _homeFcmController.refreshData();
      },
      onLoading: () => _homeFcmController.loadMore(),
      controller: _homeFcmController.refreshController,
      header: AppSmartRefresherParts.waterDropHeader(context),
      footer: AppSmartRefresherParts.customFooter(context),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _widgetHeader(),
            _welcomeCard(),
            SizedBox(height: pxToSp(context, 12.5)),
            _ongoingHeader(),
            _projectsGrid(),
            SizedBox(height: pxToSp(context, 12.5)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      bloc: _profileBloc,
      listenWhen: (previous, current) =>
          current is ProfileLoading ||
          current is ProfileLoaded ||
          current is ProfileError,
      listener: (context, state) {
        if (!mounted || _ignoreProfileBlocCallbacks) return;
        if (state is ProfileLoaded) {
          _homeProfileController.handleProfileLoaded(state.response);
        } else if (state is ProfileError) {
          _homeProfileController.handleProfileError(
            state.textError?.toString() ?? '',
          );
        } else if (state is ProfileLoading) {
          _homeProfileController.handleProfileLoading();
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(child: _body()),
      ),
    );
  }
}
