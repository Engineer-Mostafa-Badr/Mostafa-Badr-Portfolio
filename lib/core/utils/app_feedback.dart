import 'package:flutter/material.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_colors.dart';
import 'package:mostafa_badr_portfolio/core/constants/app_sizes.dart';
import 'package:mostafa_badr_portfolio/core/errors/app_failure.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';

/// The one way the app talks back to a visitor about something that happened
/// off-screen — a link that would not open, a message that did not send.
///
/// Nothing in this app fails silently. If an action does not do what the
/// visitor asked, they get told, in their language, along with a way forward.
class AppFeedback {
  const AppFeedback._();

  /// Reports a failure with its recovery hint, plus an optional retry action.
  static void showFailure(
    BuildContext context,
    AppFailure failure, {
    VoidCallback? onRetry,
  }) {
    _show(
      context,
      icon: Icons.error_outline_rounded,
      accent: AppColors.danger,
      title: failure.title(context),
      detail: failure.action(context),
      actionLabel: onRetry == null ? null : Tr.k(context, 'common.retry'),
      onAction: onRetry,
    );
  }

  /// Confirms something worked, when the result is not otherwise visible.
  static void showSuccess(BuildContext context, String message) {
    _show(
      context,
      icon: Icons.check_circle_outline_rounded,
      accent: AppColors.success,
      title: message,
    );
  }

  static void _show(
    BuildContext context, {
    required IconData icon,
    required Color accent,
    required String title,
    String? detail,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) return;

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: AppDurations.snackBar,
          backgroundColor: AppColors.surfaceDark,
          elevation: 8,
          // Cap the width so the bar stays a readable column on desktop
          // instead of stretching edge to edge.
          width: null,
          margin: const EdgeInsets.all(AppSizes.lg),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusLg),
            side: BorderSide(color: accent.withValues(alpha: 0.45)),
          ),
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: accent, size: 20),
              const SizedBox(width: AppSizes.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: accent,
                        fontWeight: FontWeight.w800,
                        fontSize: 13.5,
                      ),
                    ),
                    if (detail != null) ...[
                      const SizedBox(height: AppSizes.xs),
                      Text(
                        detail,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.5,
                          height: 1.45,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          action: (actionLabel != null && onAction != null)
              ? SnackBarAction(
                  label: actionLabel,
                  textColor: accent,
                  onPressed: onAction,
                )
              : null,
        ),
      );
  }
}
