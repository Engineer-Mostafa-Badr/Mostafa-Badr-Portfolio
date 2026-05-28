import 'package:flutter/material.dart';
import 'package:mostafa_badr_portfolio/utils/app_locale.dart';

class ProjectFeature {
  final IconData icon;
  final L18n label;
  const ProjectFeature({required this.icon, required this.label});
}

class ProjectCoverSpec {
  final String logoText;
  final L18n appName;
  final L18n subtitle;
  final List<ProjectFeature> features;
  final List<Color> gradient;
  final Color accent;

  /// Optional branded artwork. When provided, the cover renders this image
  /// instead of the generated design. The footer (status + screenshot count)
  /// stays overlaid on top. Falls back to the generated cover if the file is
  /// missing.
  final String? coverImage;

  const ProjectCoverSpec({
    required this.logoText,
    required this.appName,
    required this.subtitle,
    required this.features,
    required this.gradient,
    required this.accent,
    this.coverImage,
  });
}

enum ProjectCategory { erp, realEstate, ecommerce, superApp, rideHailing }

extension ProjectCategoryX on ProjectCategory {
  String get labelKey {
    switch (this) {
      case ProjectCategory.erp:
        return 'projects.cat.erp';
      case ProjectCategory.realEstate:
        return 'projects.cat.realEstate';
      case ProjectCategory.ecommerce:
        return 'projects.cat.ecommerce';
      case ProjectCategory.superApp:
        return 'projects.cat.superApp';
      case ProjectCategory.rideHailing:
        return 'projects.cat.rideHailing';
    }
  }
}

class ProjectItem {
  final L18n title;
  final L18n shortDescription;
  final ProjectCoverSpec cover;
  final List<String> images;
  final String apkUrl;
  final String repoUrl;
  final List<String> techs;
  final L18n statusLabel;
  final Color statusColor;
  final List<L18n> impactHighlights;
  final bool featured;
  final List<ProjectCategory> categories;

  const ProjectItem({
    required this.title,
    required this.shortDescription,
    required this.cover,
    required this.images,
    required this.apkUrl,
    required this.repoUrl,
    required this.techs,
    required this.statusLabel,
    required this.statusColor,
    required this.impactHighlights,
    this.featured = false,
    this.categories = const [],
  });
}
