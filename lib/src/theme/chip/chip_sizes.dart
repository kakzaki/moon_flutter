import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:moon_design/src/theme/chip/chip_size_properties.dart';
import 'package:moon_design/src/theme/tokens/tokens.dart';

@immutable
class MoonChipSizes extends ThemeExtension<MoonChipSizes> with DiagnosticableTreeMixin {
  /// MDS tokens.
  final MoonTokens tokens;

  /// Small chip properties.
  final MoonChipSizeProperties sm;

  /// Medium chip properties.
  final MoonChipSizeProperties md;

  MoonChipSizes({
    required this.tokens,
    MoonChipSizeProperties? sm,
    MoonChipSizeProperties? md,
  })  : sm = sm ??
            MoonChipSizeProperties(
              borderRadius: tokens.borders.interactiveXs,
              gap: tokens.sizes.x4s,
              height: tokens.sizes.sm,
              iconSizeValue: tokens.sizes.x2s,
              padding: EdgeInsets.symmetric(horizontal: tokens.sizes.x3s),
              textStyle: tokens.typography.heading.textDefault,
            ),
        md = md ??
            MoonChipSizeProperties(
              borderRadius: tokens.borders.interactiveSm,
              gap: tokens.sizes.x4s,
              height: tokens.sizes.md,
              iconSizeValue: tokens.sizes.xs,
              padding: EdgeInsets.symmetric(horizontal: tokens.sizes.x3s),
              textStyle: tokens.typography.heading.textDefault,
            );

  @override
  MoonChipSizes copyWith({
    MoonTokens? tokens,
    MoonChipSizeProperties? sm,
    MoonChipSizeProperties? md,
  }) {
    return MoonChipSizes(
      tokens: tokens ?? this.tokens,
      sm: sm ?? this.sm,
      md: md ?? this.md,
    );
  }

  @override
  MoonChipSizes lerp(ThemeExtension<MoonChipSizes>? other, double t) {
    if (other is! MoonChipSizes) return this;

    return MoonChipSizes(
      tokens: tokens.lerp(other.tokens, t),
      sm: sm.lerp(other.sm, t),
      md: md.lerp(other.md, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty("type", "MoonChipSizes"))
      ..add(DiagnosticsProperty<MoonTokens>("tokens", tokens))
      ..add(DiagnosticsProperty<MoonChipSizeProperties>("sm", sm))
      ..add(DiagnosticsProperty<MoonChipSizeProperties>("md", md));
  }
}
