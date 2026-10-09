// ignore: avoid_web_libraries_in_flutter
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_assets.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_colors.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_sizes.dart';
import 'package:mostafa_badr_portfolio/core/utils/responsive.dart';
import 'package:mostafa_badr_portfolio/core/utils/url_launcher_service.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/widgets/common/app_button.dart';
import 'package:web/web.dart' as web;

/// In-page CV preview — an `<iframe>` so the browser's native PDF viewer does
/// the rendering (no bundle bloat, no PDF SDK).
///
/// Some browsers and most in-app webviews refuse to embed PDFs. Rather than
/// leaving a blank rectangle, the modal always shows a standing explanation
/// behind the frame plus a Download action, so the visitor has a working path
/// to the résumé no matter what the browser decides.
class CvPreviewModal extends StatefulWidget {
  final String pdfUrl;

  const CvPreviewModal({super.key, this.pdfUrl = AppAssets.cvPdf});

  static void show(BuildContext context, {String pdfUrl = AppAssets.cvPdf}) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) => CvPreviewModal(pdfUrl: pdfUrl),
    );
  }

  @override
  State<CvPreviewModal> createState() => _CvPreviewModalState();
}

class _CvPreviewModalState extends State<CvPreviewModal> {
  late final String _viewType = 'cv-preview-iframe-${widget.pdfUrl.hashCode}';

  @override
  void initState() {
    super.initState();
    ui_web.platformViewRegistry.registerViewFactory(_viewType, (int _) {
      final iframe = web.document.createElement('iframe')
          as web.HTMLIFrameElement;
      iframe
        ..src = widget.pdfUrl
        ..title = 'Mostafa Badr — Resume'
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%';
      return iframe;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    // Cap the frame instead of deriving it straight from the viewport: on a
    // short window `height * 0.78` leaves no room for the header, and on a
    // very tall one it stretches past anything useful.
    final previewHeight = context.heightFraction(
      isMobile ? 0.62 : 0.74,
      min: 280,
      max: 820,
    );

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppSizes.md : 48,
        vertical: isMobile ? AppSizes.lg : 36,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppSizes.cvModalMaxWidth),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.radiusXl),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: AppColors.modalSurface,
            ),
            border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 30,
                spreadRadius: 4,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radiusXl),
            // The header can wrap to two rows on a narrow phone, so the whole
            // sheet scrolls rather than overflowing the dialog.
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _Header(
                    isMobile: isMobile,
                    onDownload: () =>
                        openUrl(widget.pdfUrl, context: context),
                    onClose: () => Navigator.of(context).pop(),
                  ),
                  Container(
                    height: 1,
                    color: Colors.white.withValues(alpha: 0.06),
                  ),
                  SizedBox(
                    height: previewHeight,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Sits *behind* the iframe: if the browser refuses to
                        // render the PDF the frame is transparent and this
                        // shows through, so the visitor is never left staring
                        // at an empty box wondering what broke.
                        const _PreviewFallback(),
                        HtmlElementView(viewType: _viewType),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
          .animate()
          .fadeIn(duration: 220.ms)
          .scale(begin: const Offset(0.96, 0.96), end: const Offset(1, 1)),
    );
  }
}

class _Header extends StatelessWidget {
  final bool isMobile;
  final VoidCallback onDownload;
  final VoidCallback onClose;

  const _Header({
    required this.isMobile,
    required this.onDownload,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final title = Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSizes.sm),
          decoration: BoxDecoration(
            color: AppColors.gold.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          ),
          child: const Icon(
            Icons.description_outlined,
            color: AppColors.gold,
            size: 20,
          ),
        ),
        const SizedBox(width: AppSizes.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                Tr.k(context, 'cv.title'),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: AppSizes.xxs),
              Text(
                Tr.k(context, 'cv.subtitle'),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );

    final actions = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppButton(
          label: Tr.k(context, 'common.download'),
          icon: Icons.download_rounded,
          size: AppButtonSize.small,
          onPressed: onDownload,
        ),
        const SizedBox(width: AppSizes.xs + 2),
        IconButton(
          onPressed: onClose,
          icon: const Icon(Icons.close_rounded),
          color: Colors.grey[300],
          tooltip: Tr.k(context, 'common.close'),
        ),
      ],
    );

    // On a phone the title and the two actions cannot share a row without the
    // title collapsing to a couple of characters — stack them instead.
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSizes.headerGap,
        14,
        isMobile ? AppSizes.md : AppSizes.md,
        AppSizes.md,
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                title,
                const SizedBox(height: AppSizes.md),
                Align(alignment: AlignmentDirectional.centerEnd, child: actions),
              ],
            )
          : Row(
              children: [
                Expanded(child: title),
                const SizedBox(width: AppSizes.sm),
                actions,
              ],
            ),
    );
  }
}

class _PreviewFallback extends StatelessWidget {
  const _PreviewFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.25),
      padding: const EdgeInsets.all(AppSizes.xxl),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.picture_as_pdf_outlined,
            size: 40,
            color: Colors.white.withValues(alpha: 0.35),
          ),
          const SizedBox(height: AppSizes.md),
          Text(
            Tr.k(context, 'cv.previewUnavailable'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.75),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSizes.sm),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Text(
              Tr.k(context, 'cv.previewUnavailableHint'),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12.5,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
