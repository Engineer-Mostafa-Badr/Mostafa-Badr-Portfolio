import 'package:flutter/material.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_colors.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_sizes.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';

/// Bundled image that degrades gracefully and decodes at display size.
///
/// Two problems this solves:
///
/// * **A missing or corrupt asset shows an explanation**, not a bare grey
///   `broken_image` glyph. The visitor learns the artwork failed to load,
///   which is honest, instead of wondering whether the layout is broken.
/// * **Decode cost is capped.** The project screenshots ship at up to 3.6 MB
///   and full phone resolution; without `cacheWidth` the engine decodes every
///   one at native size into memory. Passing the layout width lets the decoder
///   downsample first, which is the single largest rendering win available
///   here short of re-encoding the files.
class SafeAssetImage extends StatelessWidget {
  final String path;
  final BoxFit fit;
  final Alignment alignment;

  /// Logical width the image will occupy. Multiplied by the device pixel ratio
  /// to pick a decode target. Omit only when the size is genuinely unknown.
  final double? displayWidth;

  /// Shown instead of the built-in message when the asset cannot be decoded.
  final Widget? fallback;

  const SafeAssetImage({
    required this.path,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.displayWidth,
    this.fallback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ratio = MediaQuery.devicePixelRatioOf(context);
    final cacheWidth = displayWidth == null
        ? null
        : (displayWidth! * ratio).round().clamp(1, 4096);

    return Image.asset(
      path,
      fit: fit,
      alignment: alignment,
      cacheWidth: cacheWidth,
      filterQuality: FilterQuality.medium,
      errorBuilder: (context, error, stack) =>
          fallback ?? _ImageUnavailable(path: path),
    );
  }
}

class _ImageUnavailable extends StatelessWidget {
  final String path;
  const _ImageUnavailable({required this.path});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Below this the icon plus two lines of text cannot fit; show the
        // glyph alone rather than clipping the copy.
        final compact = constraints.maxHeight < 120;

        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(AppSizes.md),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: AppColors.cardSheen,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.image_not_supported_outlined,
                size: compact ? 22 : 34,
                color: Colors.white.withValues(alpha: 0.45),
              ),
              if (!compact) ...[
                const SizedBox(height: AppSizes.sm),
                Text(
                  Tr.k(context, 'error.imageUnavailable'),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
