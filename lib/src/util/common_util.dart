import 'package:flutter/material.dart';

class CommonUtil {
  static List<Widget> renderStars(dynamic start, int maxStar, double size) {
    List<Widget> stars = [];
    int _start = start.round();
    for (int i = 0; i < maxStar; i++) {
      if (i < _start) {
        stars.add(Icon(
          const IconData(0xe5f9, fontFamily: 'MaterialIcons'),
          color: Colors.amber,
          size: size,
        ));
      } else {
        stars.add(Icon(
          const IconData(0xe5f9, fontFamily: 'MaterialIcons'),
          size: size,
        ));
      }
    }
    return stars;
  }
}
