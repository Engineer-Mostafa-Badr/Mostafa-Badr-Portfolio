import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SkillIcon {
  final IconData icon;
  final Color color;
  const SkillIcon(this.icon, this.color);
}

SkillIcon iconForSkill(String skill, Color fallback) {
  final key = skill.toLowerCase();

  if (key.contains('flutter')) {
    return const SkillIcon(FontAwesomeIcons.flutter, Color(0xFF42A5F5));
  }
  if (key.contains('dart')) {
    return const SkillIcon(FontAwesomeIcons.code, Color(0xFF0175C2));
  }
  if (key.contains('firebase')) {
    return const SkillIcon(FontAwesomeIcons.fire, Color(0xFFFFA000));
  }
  if (key.contains('supabase')) {
    return const SkillIcon(FontAwesomeIcons.database, Color(0xFF3ECF8E));
  }
  if (key.contains('odoo')) {
    return const SkillIcon(FontAwesomeIcons.boxesStacked, Color(0xFF714B67));
  }
  if (key.contains('laravel')) {
    return const SkillIcon(FontAwesomeIcons.laravel, Color(0xFFFF2D20));
  }
  if (key.contains('node')) {
    return const SkillIcon(FontAwesomeIcons.nodeJs, Color(0xFF68A063));
  }
  if (key.contains('rest')) {
    return const SkillIcon(FontAwesomeIcons.cloudArrowDown, Color(0xFF40C4FF));
  }
  if (key.contains('json-rpc') || key.contains('jsonrpc')) {
    return const SkillIcon(FontAwesomeIcons.fileImport, Color(0xFF9C7BFF));
  }
  if (key.contains('dio')) {
    return const SkillIcon(FontAwesomeIcons.networkWired, Color(0xFF22D3EE));
  }
  if (key.contains('bearer') || key.contains('cookie auth')) {
    return const SkillIcon(FontAwesomeIcons.key, Color(0xFFFFD700));
  }
  if (key.contains('swagger')) {
    return const SkillIcon(FontAwesomeIcons.fileCode, Color(0xFF85EA2D));
  }
  if (key.contains('postman')) {
    return const SkillIcon(FontAwesomeIcons.paperPlane, Color(0xFFFF6C37));
  }
  if (key.contains('bloc') || key.contains('cubit')) {
    return const SkillIcon(FontAwesomeIcons.cubes, Color(0xFF02569B));
  }
  if (key.contains('provider')) {
    return const SkillIcon(FontAwesomeIcons.shareNodes, Color(0xFF9C7BFF));
  }
  if (key.contains('getx')) {
    return const SkillIcon(FontAwesomeIcons.bolt, Color(0xFF8E44AD));
  }
  if (key.contains('oop')) {
    return const SkillIcon(FontAwesomeIcons.diagramProject, Color(0xFF40C4FF));
  }
  if (key.contains('solid')) {
    return const SkillIcon(FontAwesomeIcons.cube, Color(0xFFFF8A65));
  }
  if (key.contains('clean architecture')) {
    return const SkillIcon(FontAwesomeIcons.sitemap, Color(0xFF40C4FF));
  }
  if (key.contains('design pattern')) {
    return const SkillIcon(FontAwesomeIcons.shapes, Color(0xFF9C7BFF));
  }
  if (key.contains('clean code')) {
    return const SkillIcon(FontAwesomeIcons.broom, Color(0xFF69F0AE));
  }
  if (key.contains('mvvm')) {
    return const SkillIcon(FontAwesomeIcons.layerGroup, Color(0xFFFFD700));
  }
  if (key.contains('responsive')) {
    return const SkillIcon(FontAwesomeIcons.mobileScreen, Color(0xFF40C4FF));
  }
  if (key.contains('cross-platform')) {
    return const SkillIcon(FontAwesomeIcons.layerGroup, Color(0xFFFFD700));
  }
  if (key.contains('push notification')) {
    return const SkillIcon(FontAwesomeIcons.bell, Color(0xFFFFD700));
  }
  if (key.contains('payment')) {
    return const SkillIcon(FontAwesomeIcons.creditCard, Color(0xFF69F0AE));
  }
  if (key.contains('google map')) {
    return const SkillIcon(FontAwesomeIcons.mapLocationDot, Color(0xFF34A853));
  }
  if (key.contains('openstreetmap') || key.contains('flutter_map')) {
    return const SkillIcon(FontAwesomeIcons.map, Color(0xFF7EBC6F));
  }
  if (key.contains('geolocation') || key.contains('gps')) {
    return const SkillIcon(FontAwesomeIcons.locationCrosshairs, Color(0xFF22D3EE));
  }
  if (key.contains('otp')) {
    return const SkillIcon(FontAwesomeIcons.shieldHalved, Color(0xFFFFD700));
  }
  if (key.contains('voice') || key.contains('whisper')) {
    return const SkillIcon(FontAwesomeIcons.microphone, Color(0xFFFF6B6B));
  }
  if (key.contains('share intent') || key == 'share') {
    return const SkillIcon(FontAwesomeIcons.shareNodes, Color(0xFF40C4FF));
  }
  if (key.contains('file picker') || key.contains('document')) {
    return const SkillIcon(FontAwesomeIcons.fileLines, Color(0xFF9C7BFF));
  }
  if (key.contains('qr') || key.contains('nfc')) {
    return const SkillIcon(FontAwesomeIcons.qrcode, Color(0xFF69F0AE));
  }
  if (key.contains('hijri') || key.contains('calendar')) {
    return const SkillIcon(FontAwesomeIcons.calendarDays, Color(0xFFFBBF24));
  }
  if (key.contains('offline') || key.contains('queue')) {
    return const SkillIcon(FontAwesomeIcons.cloudArrowUp, Color(0xFF9C7BFF));
  }
  if (key.contains('multi-tenant') || key.contains('multi tenant')) {
    return const SkillIcon(FontAwesomeIcons.buildingUser, Color(0xFF22D3EE));
  }
  if (key.contains('rtl')) {
    return const SkillIcon(FontAwesomeIcons.language, Color(0xFF40C4FF));
  }
  if (key.contains('localization')) {
    return const SkillIcon(FontAwesomeIcons.language, Color(0xFF40C4FF));
  }
  if (key.contains('secure storage') || key.contains('keychain') || key.contains('keystore')) {
    return const SkillIcon(FontAwesomeIcons.lock, Color(0xFFFFD700));
  }
  if (key.contains('shared preferences')) {
    return const SkillIcon(FontAwesomeIcons.floppyDisk, Color(0xFF9C7BFF));
  }
  if (key.contains('performance')) {
    return const SkillIcon(FontAwesomeIcons.gaugeHigh, Color(0xFFFF8A65));
  }
  if (key == 'git') {
    return const SkillIcon(FontAwesomeIcons.gitAlt, Color(0xFFF05032));
  }
  if (key.contains('github')) {
    return const SkillIcon(FontAwesomeIcons.github, Color(0xFFFFFFFF));
  }
  if (key.contains('ci/cd') || key.contains('cicd')) {
    return const SkillIcon(FontAwesomeIcons.arrowsSpin, Color(0xFF40C4FF));
  }
  if (key.contains('sentry')) {
    return const SkillIcon(FontAwesomeIcons.bug, Color(0xFF8C5898));
  }
  if (key.contains('icon') || key.contains('splash')) {
    return const SkillIcon(FontAwesomeIcons.icons, Color(0xFFFFD700));
  }
  if (key.contains('obfuscation') || key.contains('proguard') || key.contains('r8')) {
    return const SkillIcon(FontAwesomeIcons.userSecret, Color(0xFFFF8A65));
  }
  if (key.contains('play console') || key.contains('app store connect')) {
    return const SkillIcon(FontAwesomeIcons.googlePlay, Color(0xFF34A853));
  }
  if (key.contains('figma')) {
    return const SkillIcon(FontAwesomeIcons.figma, Color(0xFFF24E1E));
  }
  if (key.contains('feature-first') || key.contains('feature first')) {
    return const SkillIcon(FontAwesomeIcons.diagramProject, Color(0xFF22D3EE));
  }
  if (key.contains('repository pattern')) {
    return const SkillIcon(FontAwesomeIcons.database, Color(0xFF9C7BFF));
  }
  if (key.contains('go_router') || key.contains('routing')) {
    return const SkillIcon(FontAwesomeIcons.route, Color(0xFF22D3EE));
  }
  if (key.contains('get_it') || key.contains('service locator') || key.contains('dependency injection')) {
    return const SkillIcon(FontAwesomeIcons.syringe, Color(0xFFFFD700));
  }

  return SkillIcon(Icons.code, fallback);
}
