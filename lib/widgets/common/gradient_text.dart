import 'package:flutter/material.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_colors.dart';

/// Text painted with a gradient.
///
/// Replaces eleven copies of the same `ShaderMask(shaderCallback: ...)`
/// boilerplate. The shader is built from the text's own bounds so the gradient
/// tracks the glyphs rather than the parent box.
class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final List<Color> colors;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;

  const GradientText(
    this.text, {
    required this.style,
    this.colors = AppColors.brandSweep,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
    super.key,
  });

  /// The white → sky sheen used on section titles and dialog headings.
  const GradientText.titleSheen(
    this.text, {
    required this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    super.key,
  })  : colors = AppColors.titleSheen,
        begin = Alignment.centerLeft,
        end = Alignment.centerRight;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (rect) => LinearGradient(
        begin: begin,
        end: end,
        colors: colors,
      ).createShader(Rect.fromLTWH(0, 0, rect.width, rect.height)),
      child: Text(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        // The mask supplies the colour; white here keeps the glyph alpha at
        // full strength so the gradient reads at its intended saturation.
        style: style.copyWith(color: Colors.white),
      ),
    );
  }
}
