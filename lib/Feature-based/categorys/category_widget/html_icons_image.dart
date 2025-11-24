import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/widgets.dart';

IconData getIconDataFromHtml(String html) {
  if (html.contains('fa-credit-card')) return FontAwesomeIcons.creditCard;
  if (html.contains('fa-building') && html.contains("far")) return FontAwesomeIcons.building;
  if (html.contains('fa-building') && html.contains("fas")) return FontAwesomeIcons.building;
  if (html.contains('fa-list-alt')) return FontAwesomeIcons.listAlt;
  if (html.contains('fa-address-card-o')) return FontAwesomeIcons.addressCard;

  return FontAwesomeIcons.circleQuestion;
}
