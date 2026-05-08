import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/themes/app_colors.dart';
import '../../config/themes/notifiers/theme_manager.dart';
import '../../utils/responsive_configuration.dart';

// default textfield in app
class TextfieldDefault extends StatefulWidget {
  TextfieldDefault({
    Key? key,
    required this.onChanged,
    this.maxLength = 100,
    this.minLine = 1,
    this.maxLine = 1,
    required this.controller,
    required this.textColor,
    this.focusedBorderColor = AppColors.accent_light,
    required this.enabledBorderColor,
    required this.hintText,
    required this.textInputAction,
    required this.textInputType,
    this.inputFormatters,
    this.showError = false,
    this.errorMessage,
  }) : super(key: key);

  final Function(String?) onChanged;
  final TextEditingController controller;
  final Color textColor;
  final Color focusedBorderColor;
  final Color enabledBorderColor;
  final String hintText;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final int maxLength;
  final int minLine;
  final int maxLine;
  final List<TextInputFormatter>? inputFormatters;
  final bool showError;
  final String? errorMessage;
  @override
  State<TextfieldDefault> createState() => _TextfieldDefaultState();
}

class _TextfieldDefaultState extends State<TextfieldDefault> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  OutlineInputBorder _buildBorder(BuildContext context, Color color,
      {double width = 2}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(pxToSp(context, 12)),
      ),
      borderSide: BorderSide(
        color: color,
        width: pxToSp(context, width),
      ),
    );
  }

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
    return TextField(
      focusNode: _focusNode,
      onChanged: widget.onChanged,
      controller: widget.controller,
      keyboardType: widget.textInputType,
      textInputAction: widget.textInputAction,
      maxLength: widget.maxLength,
      minLines: widget.minLine,
      maxLines: widget.maxLine,
      style: AppThemeNotifier.getTextStyleFromTheme(
        baseStyle: Theme.of(context).textTheme.bodyMedium,
        color: widget.textColor,
      ),
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        errorText: widget.showError
            ? (widget.errorMessage ?? "Field is required")
            : null,
        errorStyle: AppThemeNotifier.getTextStyleFromTheme(
          baseStyle: Theme.of(context).textTheme.bodySmall,
          color: AppColors.error_primary_500,
        ),
        border: _buildBorder(context, widget.enabledBorderColor),
        enabledBorder: _buildBorder(context, widget.enabledBorderColor),
        disabledBorder: _buildBorder(context, widget.enabledBorderColor),
        focusedBorder: _buildBorder(
          context,
          widget.focusedBorderColor,
          width: pxToSp(context, 2),
        ),
        errorBorder: _buildBorder(
          context,
          AppColors.error_primary_500,
          width: pxToSp(context, 2),
        ),
        focusedErrorBorder: _buildBorder(
          context,
          AppColors.error_primary_500,
          width: pxToSp(context, 2),
        ),
        counter: Offstage(),
        fillColor: _isFocused
            ? widget.focusedBorderColor.withValues(alpha: 0.08)
            : Theme.of(context).cardColor,
        filled: true,
        contentPadding: EdgeInsets.fromLTRB(pxToSp(context, 18),
            pxToSp(context, 9), pxToSp(context, 18), pxToSp(context, 9)),
        hintStyle: AppThemeNotifier.getTextStyleFromTheme(
          baseStyle: Theme.of(context).textTheme.bodyMedium,
          color: widget.textColor,
        ),
        hintText: widget.hintText,
      ),
    );
  }
}
