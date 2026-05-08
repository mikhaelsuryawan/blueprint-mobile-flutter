import 'package:flutter/material.dart';
import '../../../config/themes/notifiers/theme_manager.dart';
import '../../../utils/responsive_configuration.dart';

class ProjectCardData {
  ProjectCardData({
    required this.date,
    required this.title,
    required this.category,
    required this.progress,
    required this.icon,
    this.isPrimary = false,
  });

  final DateTime date;
  final String title;
  final String category;
  final double progress; // 0..1
  final IconData icon;
  final bool isPrimary;
}

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    Key? key,
    required this.data,
    required this.onTap,
  }) : super(key: key);

  final ProjectCardData data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dateStr =
        '${_two(data.date.day)} ${_month(data.date.month)} ${data.date.year}';

    return InkWell(
      borderRadius: BorderRadius.circular(pxToSp(context, 12)),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(pxToSp(context, 18)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(pxToSp(context, 12)),
          boxShadow: [
            BoxShadow(
              color:
                  Theme.of(context).colorScheme.shadow.withValues(alpha: 0.15),
              blurRadius: 25,
              offset: const Offset(0, -3),
            ),
          ],
          border: Border.all(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.12),
          ),
          // subtle gradient on hero
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date
            Text(
              dateStr,
              style: AppThemeNotifier.getTextStyleFromTheme(
                baseStyle: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            SizedBox(height: pxToSp(context, 8)),

            // Icon + Title
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(data.icon,
                    color: Theme.of(context).iconTheme.color, size: pxToSp(context, 18)),
                SizedBox(width: pxToSp(context, 8)),
                Expanded(
                  child: Text(
                    data.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppThemeNotifier.getTextStyleFromTheme(
                      fontWeight: FontWeight.w600,
                      baseStyle: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: pxToSp(context, 8)),

            // Category
            Text(
              data.category,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppThemeNotifier.getTextStyleFromTheme(
                baseStyle: Theme.of(context).textTheme.bodySmall,
              ),
            ),

            const Spacer(),

            // Progress label
            Text(
              'Progress',
              style: AppThemeNotifier.getTextStyleFromTheme(
                color: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .color!
                    .withValues(alpha: 0.8),
                baseStyle: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            SizedBox(height: pxToSp(context, 6)),

            // Progress bar
            _ProgressBar(
              value: data.progress,
              bg: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .color!
                  .withValues(alpha: 0.3),
              fg: Theme.of(context).textTheme.bodyMedium!.color!,
            ),
            SizedBox(height: pxToSp(context, 2)),

            // Percent
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${(data.progress * 100).round()}%',
                style: AppThemeNotifier.getTextStyleFromTheme(
                  baseStyle: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _two(int n) => n.toString().padLeft(2, '0');
  String _month(int m) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[m - 1];
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({
    Key? key,
    required this.value,
    required this.bg,
    required this.fg,
  }) : super(key: key);

  final double value; // 0..1
  final Color bg;
  final Color fg;

  @override
  Widget build(BuildContext context) {
    final double clamped = value.clamp(0.0, 1.0).toDouble();

    return ClipRRect(
      borderRadius: BorderRadius.circular(pxToSp(context, 20)),
      child: SizedBox(
        height: 8,
        child: Stack(
          children: [
            Container(color: bg),
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 2000),
              curve: Curves.easeOutCubic,
              tween: Tween<double>(begin: 0, end: clamped),
              builder: (context, animatedValue, _) {
                return FractionallySizedBox(
                  widthFactor: animatedValue,
                  child: Container(color: fg),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
