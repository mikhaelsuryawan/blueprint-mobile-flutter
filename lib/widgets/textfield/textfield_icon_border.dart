import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/themes/app_colors.dart';
import '../../constants/assets_path.dart';
import '../../utils/responsive_configuration.dart';

// custom widget textfield using icon on the right side
class TextfieldIconBorder extends StatefulWidget {
  TextfieldIconBorder({
    Key? key,
    required this.textHint,
    required this.buttonColor,
    required this.icon,
    this.onPressed,
    this.onSubmitted,
    this.textColor = Colors.white,
    this.borderColor = AppColors.gray_primary_100,
    this.isFullWidth = false,
    this.inputFormatters,
  }) : super(key: key);

  final String textHint;
  final VoidCallback? onPressed;
  final Function(String)? onSubmitted;
  final Color buttonColor, textColor, borderColor;
  final bool isFullWidth;
  final String icon;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<TextfieldIconBorder> createState() => _TextfieldIconBorderState();
}

class _TextfieldIconBorderState extends State<TextfieldIconBorder> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.isFullWidth
          ? SizedBox(
              width: double.infinity,
              child: _makeButton(context),
            )
          : SizedBox(
              child: _makeButton(context),
            ),
    );
  }

  Widget _makeButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: pxToSp(context, 12)),
      decoration: BoxDecoration(
        border:
            Border.all(color: widget.buttonColor, width: pxToSp(context, 2)),
        borderRadius: BorderRadius.all(
          Radius.circular(pxToSp(context, 12)),
        ),
        color: _isFocused
            ? widget.buttonColor.withValues(alpha: 0.08)
            : Theme.of(context).cardColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              focusNode: _focusNode,
              onTap: widget.onPressed,
              onSubmitted: widget.onSubmitted,
              textInputAction: TextInputAction.search,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: widget.textColor),
              inputFormatters: widget.inputFormatters,
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(pxToSp(context, 12)),
                  ),
                  borderSide: BorderSide(color: Colors.transparent, width: 0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(pxToSp(context, 12)),
                  ),
                  borderSide: BorderSide(color: Colors.transparent, width: 0),
                ),
                contentPadding: EdgeInsets.all(pxToSp(context, 12)),
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: widget.textColor),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(pxToSp(context, 12)),
                  child: SvgPicture.asset(
                    Assets.search,
                    colorFilter: _isFocused
                        ? ColorFilter.mode(widget.buttonColor, BlendMode.srcIn)
                        : null,
                  ),
                ),
                hintText: widget.textHint,
              ),
            ),
          ),
          SvgPicture.asset(
            Assets.microphone,
            colorFilter: _isFocused
                ? ColorFilter.mode(widget.buttonColor, BlendMode.srcIn)
                : null,
          ),
        ],
      ),
    );
  }
}
