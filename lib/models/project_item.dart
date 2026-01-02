import 'package:flutter/material.dart';

class ProjectItem {
  final String title;
  final String shortDescription;
  final List<String> images;
  final String apkUrl;
  final String repoUrl;
  final List<String> techs;
  final String statusLabel;
  final Color statusColor;
  final List<String> impactHighlights;

  ProjectItem({
    required this.title,
    required this.shortDescription,
    required this.images,
    required this.apkUrl,
    required this.repoUrl,
    required this.techs,
    required this.statusLabel,
    required this.statusColor,
    required this.impactHighlights,
  });
}
