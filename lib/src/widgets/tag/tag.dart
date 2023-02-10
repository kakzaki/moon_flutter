import 'package:flutter/material.dart';
import 'package:moon_design/src/theme/colors.dart';

import 'package:moon_design/src/theme/tag/tag_sizes.dart';
import 'package:moon_design/src/theme/theme.dart';
import 'package:moon_design/src/utils/extensions.dart';

enum MoonTagSize {
  x2s,
  xs,
}

class MoonTag extends StatelessWidget {
  /// The callback that is called when the tag is tapped or pressed.
  final VoidCallback? onTap;

  /// The callback that is called when the tag is long-pressed.
  final VoidCallback? onLongPress;

  /// The size of the tag.
  final MoonTagSize? tagSize;

  /// The semantic label for the tag.
  final String? semanticLabel;

  /// The width of the tag.
  final double? width;

  /// The height of the tag.
  final double? height;

  /// The gap between the icon and the label.
  final double? gap;

  /// The background color of the tag.
  final Color? backgroundColor;

  /// The text color of the tag.
  final Color? textColor;

  /// The padding of the tag.
  final EdgeInsets? padding;

  /// The border radius of the tag.
  final BorderRadius? borderRadius;

  /// Whether the tag should use upper case text style.
  final bool isUpperCase;

  /// The widget in the left icon slot of the tag.
  final Widget? leftIcon;

  /// The widget in the label slot of the tag.
  final Widget? label;

  /// The widget in the right icon slot of the tag.
  final Widget? rightIcon;

  const MoonTag({
    super.key,
    this.onTap,
    this.onLongPress,
    this.tagSize,
    this.semanticLabel,
    this.width,
    this.height,
    this.gap,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.borderRadius,
    this.isUpperCase = true,
    this.leftIcon,
    this.label,
    this.rightIcon,
  });

  MoonTagSizes _getMoonTagSize(BuildContext context, MoonTagSize? moonTagSize) {
    switch (moonTagSize) {
      case MoonTagSize.x2s:
        return context.moonTheme?.tagTheme.x2s ?? MoonTagSizes.x2s;
      case MoonTagSize.xs:
        return context.moonTheme?.tagTheme.xs ?? MoonTagSizes.xs;
      default:
        return context.moonTheme?.tagTheme.xs ?? MoonTagSizes.xs;
    }
  }

  Color _getTextColor({required bool isDarkMode, required Color backgroundColor}) {
    final backgroundLuminance = backgroundColor.computeLuminance();
    if (backgroundLuminance > 0.5) {
      return MoonColors.light.bulma;
    } else {
      return MoonColors.dark.bulma;
    }
  }

  @override
  Widget build(BuildContext context) {
    final MoonTagSizes effectiveMoonTagSize = _getMoonTagSize(context, tagSize);

    final double effectiveHeight = height ?? effectiveMoonTagSize.height;
    final double effectiveGap = gap ?? effectiveMoonTagSize.gap;

    final BorderRadius effectiveBorderRadius = borderRadius ?? effectiveMoonTagSize.borderRadius;

    final Color effectiveBackgroundColor = backgroundColor ?? context.moonColors?.gohan ?? MoonColors.light.gohan;

    final Color effectiveTextColor =
        textColor ?? _getTextColor(isDarkMode: context.isDarkMode, backgroundColor: effectiveBackgroundColor);

    final EdgeInsets effectivePadding = padding ?? effectiveMoonTagSize.padding;

    final EdgeInsetsDirectional correctedPadding = EdgeInsetsDirectional.fromSTEB(
      leftIcon == null && label != null ? effectivePadding.left : 0,
      effectivePadding.top,
      rightIcon == null && label != null ? effectivePadding.right : 0,
      effectivePadding.bottom,
    );

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        height: effectiveHeight,
        padding: correctedPadding,
        constraints: BoxConstraints(minWidth: effectiveHeight),
        decoration: BoxDecoration(
          color: effectiveBackgroundColor,
          borderRadius: effectiveBorderRadius,
        ),
        child: DefaultTextStyle.merge(
          style: isUpperCase
              ? effectiveMoonTagSize.upperCaseTextStyle.copyWith(color: effectiveTextColor)
              : effectiveMoonTagSize.textStyle.copyWith(color: effectiveTextColor),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leftIcon != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: effectiveGap),
                  child: leftIcon,
                ),
              if (label != null) label!,
              if (rightIcon != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: effectiveGap),
                  child: rightIcon,
                ),
            ],
          ),
        ),
      ),
    );
  }
}