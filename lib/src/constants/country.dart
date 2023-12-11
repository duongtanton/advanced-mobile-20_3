import 'dart:convert';

import 'package:flutter/services.dart';

class CountryService {
  static Map<String, String> countriesMap = {};

  static Future<void> loadCountries() async {
    String data = await rootBundle.loadString('assets/data/countries.json');
    List<dynamic> countriesJson = jsonDecode(data);
    Map<String, String> map = {
      for (var country in countriesJson) country["code"]: country["name"]
    };
    countriesMap = map;
  }
}
