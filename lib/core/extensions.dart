import 'package:flutter/material.dart';
import 'package:movie_app/core/enums.dart';

extension MovieImageExtension on MovieNameEnum {
  String get movieImage => "assets/images/movies/$name.png";
}

extension SocialMediaExtension on SocialMediaEnum {
  String get socialIcon => "assets/images/social_media/$name.png";
}

extension ContextExtension on BuildContext {
  double get deviceHeight => MediaQuery.of(this).size.height;
  double get deviceWidth => MediaQuery.of(this).size.width;
  TextTheme get textTheme => Theme.of(this).textTheme;
}
