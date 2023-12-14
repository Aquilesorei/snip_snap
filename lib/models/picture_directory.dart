

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class PictureDirectory {
  List<String> men;
  List<String> salon;
  List<String> women;
  List<String> coloredWomen;
  List<String> coloredMan;
  List<String> occasion;

  PictureDirectory({
    required this.men,
    required this.salon,
    required this.women,
    required this.coloredMan,
    required this.coloredWomen,
    required this.occasion
  });

  factory PictureDirectory.fromJson(Map<String, dynamic> json) {
    return PictureDirectory(
      men: List<String>.from(json['men']),
      salon: List<String>.from(json['salon']),
      women: List<String>.from(json['women']),
      coloredMan: List<String>.from(json['colored_men']),
      coloredWomen: List<String>.from(json['colored_women']),
      occasion: List<String>.from(json['occasion'])
    );
  }

  static Future<PictureDirectory> fromJsonAsset(String assetPath) async {
    final jsonString = await rootBundle.loadString(assetPath);
    final jsonMap = json.decode(jsonString);
    return PictureDirectory.fromJson(jsonMap);
  }
}



