import 'package:flutter/material.dart';

Color primaryTextColor = Colors.blue;
Color secondaryTextColor = Colors.lightBlue;
Color titleTextColor = Colors.white;
Color contentTextColor = Color(0xff868686);
Color navigationColor = Color(0xFF6751B5);
Color gradientStartColor = Color(0xFF0050AC);
Color gradientEndColor = Color(0xFF9354B9);

OutlineInputBorder kInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(color: Colors.grey.shade200, width: .5));

enum MediaQueryTypes { width, height }

double getMediaQuery(BuildContext context, MediaQueryTypes types) {
  if (types == MediaQueryTypes.width) {
    return MediaQuery.of(context).size.width;
  }
  return MediaQuery.of(context).size.height;
}

const String kAppName = 'AirsoftFun';
const String kDevBaseUrl = 'https://openapi.mrstein.web.id';
const String kProdBaseUrl = '';
const String kImageUrl = 'https://openapi.mrstein.web.id/uploads';
