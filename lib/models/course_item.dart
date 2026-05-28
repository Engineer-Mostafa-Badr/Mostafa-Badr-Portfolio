import 'package:mostafa_badr_portfolio/utils/app_locale.dart';

class CourseItem {
  final L18n title;
  final L18n description;
  final String image;
  final String certificateUrl;

  const CourseItem({
    required this.title,
    required this.description,
    required this.image,
    required this.certificateUrl,
  });
}
