import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../config/themes/notifiers/theme_manager.dart';
import '../../constants/assets_path.dart';
import '../shimmers/shimmer_rounded_rectangle.dart';

// Default image profile viewer
class ImageProfileExtended extends StatelessWidget {
  const ImageProfileExtended({
    Key? key,
    this.imageUrl = '',
    this.alt = '',
    this.useAlt = false,
    this.useShimmer = false,
    this.borderRadius = 10.0,
    this.height = double.infinity,
    this.width = double.infinity,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  final String? imageUrl;
  final String? alt;
  final bool useAlt;
  final bool useShimmer;
  final double borderRadius;
  final double height;
  final double width;
  final BoxFit fit;

  Widget get _placeholder {
    return ShimmerRoundedRectangle(
      height: height,
      width: width,
      borderRadius: borderRadius,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      if (useAlt) {
        return _noImageAltWidget;
      } else {
        return _noImageWidget;
      }
    }
    return Container(
      height: height,
      width: width,
      child: CachedNetworkImage(
        imageUrl: imageUrl!,
        height: height,
        width: width,
        fit: fit,
        imageBuilder: (context, imageProvider) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          );
        },
        placeholder: (context, url) {
          if (useShimmer) {
            return _placeholder;
          }
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 35.w,
            child: Center(
              child: SizedBox(
                width: 7.sp,
                height: 7.sp,
                child: CupertinoActivityIndicator(),
              ),
            ),
          );
        },
        errorWidget: (context, url, error) {
          if (useAlt) {
            return _noImageAltWidget;
          } else {
            return _noImageWidget;
          }
        },
      ),
    );
  }

  Widget get _noImageWidget {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SvgPicture.asset(
        Assets.avatar,
        height: height,
        width: width,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget get _noImageAltWidget {
    return Builder(
      builder: (context) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.8.sp),
          child: Center(
            child: Text(
              alt!,
              textAlign: TextAlign.center,
              style: AppThemeNotifier.getTextStyleFromTheme(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                baseStyle: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
