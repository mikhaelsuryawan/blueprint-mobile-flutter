import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:timelines_plus/timelines_plus.dart';

import '../../../config/language/app_localizations.dart';
import '../../../config/themes/app_colors.dart';
import '../../../config/themes/notifiers/theme_manager.dart';
import '../../../constants/assets_path.dart';
import '../../../core/models/career/response/career_entry.dart';
import '../../../utils/responsive_configuration.dart';
import '../../../widgets/default_appbar.dart';
import '../controller/my_career_body_controller.dart';

class MyCareerBody extends StatefulWidget {
  const MyCareerBody({super.key});

  @override
  State<MyCareerBody> createState() => _MyCareerBodyState();
}

class _MyCareerBodyState extends State<MyCareerBody>
    with TickerProviderStateMixin {
  late final MyCareerBodyController _careerController;

  @override
  void initState() {
    super.initState();
    _careerController = MyCareerBodyController(vsync: this);
  }

  @override
  void dispose() {
    _careerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: DefaultAppBar(
        context: context,
        textTitle: 'My Career',
        showBackButton: false,
      ),
      body: AnimatedBuilder(
        animation: _careerController.bgCtrl,
        builder: (context, _) {
          return Stack(
            fit: StackFit.expand,
            children: [
              SafeArea(
                child: Padding(
                  // More comfortable gutter using sizer
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 4.w : 5.w,
                  ).copyWith(top: 2.h, bottom: 2.h),
                  child: _buildTimeline(Theme.of(context), isTablet),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTimeline(ThemeData theme, bool isTablet) {
    final double cardSpacing =
        pxToSp(context, 14); // vertical space between items

    return Timeline.tileBuilder(
      theme: TimelineThemeData(
        nodePosition: isTablet ? 0.25 : 0.25,
        color: AppColors.accent_light.withValues(alpha: 0.5),
        indicatorTheme: IndicatorThemeData(
          size: isTablet ? 22 : 20,
          color: AppColors.accent_light.withValues(alpha: 0.5),
        ),
        connectorTheme: ConnectorThemeData(
          thickness: isTablet ? 4.0 : 3.5,
          color: AppColors.accent_light.withValues(alpha: 0.5),
        ),
      ),
      builder: TimelineTileBuilder.connectedFromStyle(
        itemCount: _careerController.entries.length,
        connectionDirection: ConnectionDirection.before,
        oppositeContentsBuilder: (context, index) {
          final e = _careerController.entries[index];
          return _staggered(
            index,
            child: Padding(
              padding: EdgeInsets.only(right: cardSpacing),
              child: _PeriodPill(
                text: '${e.startPeriod}',
                isTablet: isTablet,
              ),
            ),
          );
        },
        contentsBuilder: (context, index) {
          final e = _careerController.entries[index];
          return _staggered(
            index,
            child: Padding(
              padding: EdgeInsets.only(bottom: cardSpacing, left: cardSpacing),
              child: _CareerCard(
                company: e.company,
                role: e.role,
                period: '${e.startPeriod} - ${e.endPeriod}',
                onTap: () => _showDetails(e),
              ),
            ),
          );
        },
        indicatorStyleBuilder: (context, index) {
          // Keep using your dot style; styling color is via theme
          return IndicatorStyle.dot;
        },
        connectorStyleBuilder: (context, index) {
          return ConnectorStyle.solidLine; // style only; color is themed
        },
      ),
    );
  }

  /// Staggered fade + slide for each item
  Widget _staggered(int index, {required Widget child}) {
    final start = (index * 0.15).clamp(0.0, 0.9);
    final end = (start + 0.45).clamp(0.0, 1.0);
    final anim = CurvedAnimation(
      parent: _careerController.staggerCtrl,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    );

    return AnimatedBuilder(
      animation: anim,
      builder: (_, __) {
        final opacity = anim.value;
        final dy = (1 - anim.value) * 16; // slide up
        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(0, dy),
            child: child,
          ),
        );
      },
    );
  }

  void _showDetails(CareerEntry e) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      useRootNavigator: true,
      builder: (context) {
        return Container(
          width: 100.w,
          padding: EdgeInsets.all(pxToSp(context, 18)),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: pxToSp(context, 8)),
                Center(child: SvgPicture.asset(Assets.indicator)),
                SizedBox(height: pxToSp(context, 25)),
                _LabelCapsule(text: '${e.startPeriod} - ${e.endPeriod}'),
                SizedBox(height: pxToSp(context, 12)),
                Text(
                  e.role,
                  style: AppThemeNotifier.getTextStyleFromTheme(
                    fontWeight: FontWeight.w700,
                    baseStyle: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                SizedBox(height: pxToSp(context, 4)),
                Text(
                  e.company,
                  style: AppThemeNotifier.getTextStyleFromTheme(
                    baseStyle: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                SizedBox(height: pxToSp(context, 25)),
                Text(
                  GetAppLocalizations(context).careerHighlights,
                  style: AppThemeNotifier.getTextStyleFromTheme(
                    baseStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                          letterSpacing: 0.5,
                        ),
                  ),
                ),
                SizedBox(height: pxToSp(context, 8)),
                Text(
                  '• Built and maintained high-availability systems.\n'
                  '• Led mobile development initiatives (Flutter).\n'
                  '• Mentored engineers and drove best practices.',
                  style: AppThemeNotifier.getTextStyleFromTheme(
                    baseStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: 1.35,
                        ),
                  ),
                ),
                SizedBox(height: pxToSp(context, 18)),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Futuristic glass card used for each timeline node
class _CareerCard extends StatelessWidget {
  final String company;
  final String role;
  final String period;
  final VoidCallback? onTap;

  const _CareerCard({
    required this.company,
    required this.role,
    required this.period,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final border = BorderSide(
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3));
    return GestureDetector(
      onTap: onTap,
      child: _GlassContainer(
        child: Padding(
          padding: EdgeInsets.all(pxToSp(context, 14)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: pxToSp(context, 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(pxToSp(context, 4)),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF22D3EE), Color(0xFF8B5CF6)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              SizedBox(width: pxToSp(context, 12)),
              // Texts
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _LabelCapsule(text: period),
                    SizedBox(height: pxToSp(context, 12)),
                    Text(
                      role,
                      style: AppThemeNotifier.getTextStyleFromTheme(
                        fontWeight: FontWeight.w700,
                        baseStyle: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    SizedBox(height: pxToSp(context, 7)),
                    Text(
                      company,
                      style: AppThemeNotifier.getTextStyleFromTheme(
                        baseStyle: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: pxToSp(context, 12)),
              Icon(Icons.chevron_right_rounded,
                  size: pxToSp(context, 20),
                  color: Theme.of(context).textTheme.bodyMedium?.color!),
            ],
          ),
        ),
        border: border,
      ),
    );
  }
}

/// Small capsule text (for period labels)
class _PeriodPill extends StatelessWidget {
  final String text;
  final bool isTablet;
  const _PeriodPill({required this.text, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        // reasonable cap so long ranges still look neat
        maxWidth: isTablet ? 28.w : 44.w,
      ),
      child: _GlassContainer(
        border: BorderSide(
            color: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.color!
                    .withValues(alpha: 0.3) ??
                Colors.white.withValues(alpha: 0.5)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: pxToSp(context, 14), vertical: pxToSp(context, 7)),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: AppThemeNotifier.getTextStyleFromTheme(
              baseStyle: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ),
    );
  }
}

class _LabelCapsule extends StatelessWidget {
  final String text;
  const _LabelCapsule({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: pxToSp(context, 14), vertical: pxToSp(context, 7)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border:
            Border.all(color: AppColors.black_000000.withValues(alpha: 0.14)),
        color: AppColors.black_000000.withValues(alpha: 0.1),
      ),
      child: Text(
        text,
        style: AppThemeNotifier.getTextStyleFromTheme(
          baseStyle: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}

/// Reusable glass container (card style)
class _GlassContainer extends StatelessWidget {
  final Widget child;
  final BorderSide? border;

  const _GlassContainer({required this.child, this.border});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(pxToSp(context, 12)),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(pxToSp(context, 12)),
          border: Border.fromBorderSide(border ?? BorderSide.none),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.25),
              blurRadius: 20,
              spreadRadius: -6,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
