import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

import '../../config/themes/app_colors.dart';

class ImagePreview extends StatelessWidget {
  final String imageUrl;
  final String heroTag;

  const ImagePreview({
    Key? key,
    required this.imageUrl,
    required this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // tap anywhere to close
      onTap: () => Navigator.of(context).pop(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(
            children: [
              // Centered zoomable image
              Center(
                child: Hero(
                  tag: heroTag,
                  child: InteractiveViewer(
                    panEnabled: true,
                    minScale: 0.8,
                    maxScale: 4.0,
                    child: AspectRatio(
                      aspectRatio: 1, // adjust if your avatar isn't square
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.contain,
                        loadingBuilder: (c, w, p) {
                          if (p == null) return w;
                          return Center(
                            child: SizedBox(
                              width: 32.sp,
                              height: 32.sp,
                              child: LoadingAnimationWidget.inkDrop(
                                color: AppColors.white_FFFFFF,
                                size: 32.sp,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (c, e, s) => Icon(Icons.broken_image,
                            color: AppColors.white_FFFFFF),
                      ),
                    ),
                  ),
                ),
              ),

              // Close button (top-right)
              Positioned(
                top: 12.sp,
                right: 12.sp,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                  color: AppColors.white_FFFFFF,
                  iconSize: 22.sp,
                  tooltip: 'Close',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
