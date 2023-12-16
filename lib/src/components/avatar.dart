import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar(
      {super.key,
      required this.url,
      this.defaultUrl = "assets/images/teacher.jpg",
      this.size = 80});

  final String url;
  final String defaultUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size),
      child: Image.network(url, height: size, width: size, fit: BoxFit.cover,
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
        return Image.asset(
          defaultUrl,
          height: size,
          width: size,
          fit: BoxFit.cover,
        );
      }),
    );
  }
}
