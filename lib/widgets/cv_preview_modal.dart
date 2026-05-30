// ignore: deprecated_member_use, avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';
import 'package:mostafa_badr_portfolio/utils/url_utils.dart';

/// In-page CV preview modal — opens an iframe with the PDF so visitors can
/// scan the resume without leaving the portfolio, then download if they want.
///
/// Uses HtmlElementView with an `<iframe>` because the browser's built-in
/// PDF viewer renders the file natively (no bundle bloat, no SDK).
class CvPreviewModal extends StatefulWidget {
  final String pdfUrl;

  const CvPreviewModal({super.key, required this.pdfUrl});

  static void show(BuildContext context, {required String pdfUrl}) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) => CvPreviewModal(pdfUrl: pdfUrl),
    );
  }

  @override
  State<CvPreviewModal> createState() => _CvPreviewModalState();
}

class _CvPreviewModalState extends State<CvPreviewModal> {
  late final String _viewType =
      'cv-preview-iframe-${widget.pdfUrl.hashCode}';

  @override
  void initState() {
    super.initState();
    ui_web.platformViewRegistry.registerViewFactory(_viewType, (int _) {
      return html.IFrameElement()
        ..src = widget.pdfUrl
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%'
        ..allow = 'autoplay';
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;
    final ar = isArabic(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 48,
        vertical: isMobile ? 16 : 36,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0E152B), Color(0xFF1A1130)],
            ),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.10),
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 30,
                spreadRadius: 4,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ─── Header ───
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 14, 12, 12),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFD700)
                              .withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.description_outlined,
                          color: Color(0xFFFFD700),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              ar
                                  ? 'السيرة الذاتية — Mostafa Badr'
                                  : 'Resume — Mostafa Badr',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              ar
                                  ? 'Mid-Level Flutter Developer · Odoo ERP Specialist'
                                  : 'Mid-Level Flutter Developer · Odoo ERP Specialist',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 11.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Download button
                      ElevatedButton.icon(
                        onPressed: () => openUrl(widget.pdfUrl),
                        icon: const Icon(Icons.download_rounded, size: 14),
                        label: Text(ar ? 'تحميل' : 'Download'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFD700),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      // Close button
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close_rounded),
                        color: Colors.grey[300],
                        tooltip: ar ? 'إغلاق' : 'Close',
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.white.withValues(alpha: 0.06),
                ),
                // ─── PDF preview iframe ───
                SizedBox(
                  height: isMobile
                      ? MediaQuery.of(context).size.height * 0.65
                      : MediaQuery.of(context).size.height * 0.78,
                  child: HtmlElementView(viewType: _viewType),
                ),
              ],
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
